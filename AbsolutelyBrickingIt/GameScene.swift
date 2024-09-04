//
// GameScene.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 10/08/2024.
// 

import SpriteKit

protocol GameSceneCoordinator: AnyObject {
    func gameSceneGameLost(_ scene: GameScene)
    func gameSceneGameWon(_ scene: GameScene)
}

class GameScene: SKScene {
    
    weak var coordinator: GameSceneCoordinator?
    
    private var lastTouchLocation: CGPoint?
    private var paddleNode: SKSpriteNode?
    private var bricksNode: SKNode?
    
    override func didMove(to view: SKView) {
        addBackgroundNode()
        paddleNode = addPaddleNode()
        addBallNode()
        addWallsNode()
        addOutOfBoundsNode()
        bricksNode = addBricksNode()
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchLocation = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouchLocation = touches.first?.location(in: self) else { return }
        touchLocation(movedTo: firstTouchLocation)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouchLocation = touches.first?.location(in: self) else { return }
        touchLocation(movedTo: firstTouchLocation)
    }
}

private extension GameScene {
    
    func touchLocation(movedTo point: CGPoint) {
        guard let paddleNode,
              let lastTouchLocation else { return }
        
        let positionUpdateX = paddleNode.position.x + point.x - lastTouchLocation.x
        let destinationX = positionUpdateX.clamp(
            min: paddleNode.size.width * 0.5,
            max: size.width - paddleNode.size.width * 0.5)
        paddleNode.position = CGPoint(x: destinationX, y: paddleNode.position.y)
        self.lastTouchLocation = point
    }
    
    func addBackgroundNode() {
        let backgroundNode = SKSpriteNode(imageNamed: "background.menu")
        backgroundNode.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        addChild(backgroundNode)
    }
    
    func addPaddleNode() -> SKSpriteNode {
        let paddleNode = SKSpriteNode(imageNamed: "paddle")
        paddleNode.name = "paddle"
        paddleNode.position = CGPoint(x: 0.5 * size.width, y: 0.1 * size.height)
        paddleNode.physicsBody = SKPhysicsBody(rectangleOf: paddleNode.size)
        paddleNode.physicsBody?.isDynamic = false
        paddleNode.physicsBody?.categoryBitMask = PhysicsCategory.paddle
        addChild(paddleNode)
        return paddleNode
    }
    
    func addBallNode() {
        let ballNode = SKSpriteNode(imageNamed: "ball")
        ballNode.name = "ball"
        ballNode.position = CGPoint(x: 0.5 * size.width, y: 0.2 * size.height)
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballNode.size.width * 0.5)
        ballNode.physicsBody?.categoryBitMask = PhysicsCategory.ball
        ballNode.physicsBody?.collisionBitMask = PhysicsCategory.paddle | PhysicsCategory.wall | PhysicsCategory.brick
        ballNode.physicsBody?.contactTestBitMask = PhysicsCategory.outOfBounds | PhysicsCategory.brick
        ballNode.physicsBody?.friction = 0.0
        ballNode.physicsBody?.restitution = 1.0
        ballNode.physicsBody?.linearDamping = 0.0
        ballNode.physicsBody?.velocity = CGVector(dx: 0.0, dy: -200.0)
        addChild(ballNode)
    }
    
    func addWallsNode() {
        let wallsNode = WallsNode(sceneSize: size)
        addChild(wallsNode)
    }
    
    func addOutOfBoundsNode() {
        let outOfBoundsNode = SKSpriteNode(color: .white, size: CGSize(width: size.width, height: 50))
        outOfBoundsNode.name = "outOfBounds"
        outOfBoundsNode.position = CGPoint(x: 0.5 * size.width, y: -0.5 * outOfBoundsNode.size.height)
        outOfBoundsNode.physicsBody = SKPhysicsBody(rectangleOf: outOfBoundsNode.size)
        outOfBoundsNode.physicsBody?.categoryBitMask = PhysicsCategory.outOfBounds
        outOfBoundsNode.physicsBody?.isDynamic = false
        addChild(outOfBoundsNode)
    }
    
    func addBricksNode() -> SKNode {
        let bricksNode = SKNode()
        bricksNode.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        addChild(bricksNode)
        let bricks = [
            "------",
            "-------",
            "------",
            "-------"
        ]
        for (rowIndex, rowValue) in bricks.enumerated() {
            for (colIndex, brickValue) in rowValue.enumerated() {
                addBrickNode(to: bricksNode, totalColumns: rowValue.count, column: colIndex, row: rowIndex)
            }
        }
        return bricksNode
    }
    
    func addBrickNode(to parentNode: SKNode, totalColumns: Int, column: Int, row: Int) {
        let brickNode = SKSpriteNode(imageNamed: "brick")
        brickNode.name = "brick"
        let gapSize = 3
        let totalWidth = CGFloat(totalColumns) * (brickNode.size.width + CGFloat(gapSize)) - CGFloat(gapSize)
        let startX = 0.5 * (brickNode.size.width - totalWidth)
        let x = startX + CGFloat(column) * (brickNode.size.width + CGFloat(gapSize))
        let y = CGFloat(row) * (brickNode.size.height + CGFloat(gapSize))
        brickNode.position = CGPoint(x: x, y: y)
        brickNode.physicsBody = SKPhysicsBody(rectangleOf: brickNode.size)
        brickNode.physicsBody?.categoryBitMask = PhysicsCategory.brick
        brickNode.physicsBody?.isDynamic = false
        parentNode.addChild(brickNode)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            ball(node: nodeA, collidedWith: nodeB)
        } else if nodeB.name == "ball" {
            ball(node: nodeB, collidedWith: nodeA)
        }
    }
    
    private func ball(node: SKNode, collidedWith other: SKNode) {
        if other.name == "outOfBounds" {
            coordinator?.gameSceneGameLost(self)
        } else if other.name == "brick" {
            hit(brick: other)
        }
    }
    
    private func hit(brick: SKNode) {
        brick.removeFromParent()
        
        if bricksNode?.children.count == 0 {
            coordinator?.gameSceneGameWon(self)
        }
    }
}
