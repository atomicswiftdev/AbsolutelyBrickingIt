//
// GameScene.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 10/08/2024.
// 

import SpriteKit

protocol GameSceneCoordinator: AnyObject {
    func gameSceneScreenTapped(_ scene: GameScene)
}

class GameScene: SKScene {
    
    weak var coordinator: GameSceneCoordinator?
    
    private var lastTouchLocation: CGPoint?
    private var paddleNode: SKSpriteNode?
    
    private lazy var hWallSize = CGSize(width: size.width, height: 50)
    private lazy var vWallSize = CGSize(width: 50, height: size.height)
    
    private let ballCategory: UInt32 = 0x1
    private let paddleCategory: UInt32 = 0x1 << 1
    private let wallCategory: UInt32 = 0x1 << 2
    private let outOfBoundsCategory: UInt32 = 0x1 << 3
    
    override func didMove(to view: SKView) {
        addBackgroundNode()
        paddleNode = addPaddleNode()
        addBallNode()
        
        let topWallPosition = CGPoint(x: 0.5 * size.width, y: size.height + 0.5 * hWallSize.height)
        let leftWallPosition = CGPoint(x: -0.5 * vWallSize.width, y: 0.5 * size.height)
        let rightWallPosition = CGPoint(x: size.width + 0.5 * vWallSize.width, y: 0.5 * size.height)
        let outOfBoundsPosition = CGPoint(x: 0.5 * size.width, y: 0.5 * hWallSize.height)
        
        addWallNode(size: hWallSize, position: topWallPosition)
        addWallNode(size: vWallSize, position: leftWallPosition)
        addWallNode(size: vWallSize, position: rightWallPosition)
        addOutOfBoundsNode(size: hWallSize, position: outOfBoundsPosition)
        
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
        paddleNode.position = CGPoint(x: 0.5 * size.width, y: 0.1 * size.height)
        paddleNode.physicsBody = SKPhysicsBody(rectangleOf: paddleNode.size)
        paddleNode.physicsBody?.isDynamic = false
        paddleNode.physicsBody?.categoryBitMask = paddleCategory
        addChild(paddleNode)
        return paddleNode
    }
    
    func addBallNode() {
        let ballNode = SKSpriteNode(imageNamed: "ball")
        ballNode.position = CGPoint(x: 0.5 * size.width, y: 0.2 * size.height)
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballNode.size.width * 0.5)
        ballNode.physicsBody?.categoryBitMask = ballCategory
        ballNode.physicsBody?.collisionBitMask = paddleCategory | wallCategory
        ballNode.physicsBody?.contactTestBitMask = outOfBoundsCategory
        ballNode.physicsBody?.friction = 0.0
        ballNode.physicsBody?.restitution = 1.0
        ballNode.physicsBody?.linearDamping = 0.0
        ballNode.physicsBody?.velocity = CGVector(dx: 0.0, dy: -200.0)
        addChild(ballNode)
    }
    
    func addWallNode(size: CGSize, position: CGPoint) {
        let wallNode = SKSpriteNode(color: .white, size: size)
        wallNode.position = position
        wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallNode.size)
        wallNode.physicsBody?.categoryBitMask = wallCategory
        wallNode.physicsBody?.isDynamic = false
        addChild(wallNode)
    }
    
    func addOutOfBoundsNode(size: CGSize, position: CGPoint) {
        let outOfBoundsNode = SKSpriteNode(color: .white, size: size)
        outOfBoundsNode.position = position
        outOfBoundsNode.physicsBody = SKPhysicsBody(rectangleOf: outOfBoundsNode.size)
        outOfBoundsNode.physicsBody?.categoryBitMask = outOfBoundsCategory
        outOfBoundsNode.physicsBody?.isDynamic = false
        addChild(outOfBoundsNode)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Ball and out of bounds collision")
    }
}
