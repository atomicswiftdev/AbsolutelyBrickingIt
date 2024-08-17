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
    
    private var paddleNode: SKSpriteNode?
    private var lastTouchLocation: CGPoint?
    
    private lazy var topWallSize = CGSize(width: size.width, height: 50)
    private lazy var sideWallSize = CGSize(width: 50, height: size.height)
    
    override func didMove(to view: SKView) {
        let backgroundNode = SKSpriteNode(imageNamed: "background.menu")
        backgroundNode.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        addChild(backgroundNode)
        
        let paddleNode = SKSpriteNode(imageNamed: "paddle")
        paddleNode.position = CGPoint(x: 0.5 * size.width, y: 0.1 * size.height)
        paddleNode.physicsBody = SKPhysicsBody(rectangleOf: paddleNode.size)
        paddleNode.physicsBody?.isDynamic = false
        addChild(paddleNode)
        self.paddleNode = paddleNode
        
        let ballNode = SKSpriteNode(imageNamed: "ball")
        ballNode.position = CGPoint(x: 0.5 * size.width, y: 0.2 * size.height)
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballNode.size.width * 0.5)
        ballNode.physicsBody?.friction = 0.0
        ballNode.physicsBody?.restitution = 1.0
        ballNode.physicsBody?.linearDamping = 0.0
        ballNode.physicsBody?.velocity = CGVector(dx: 0.0, dy: -200.0)
        addChild(ballNode)
        
        let topWallNode = SKSpriteNode(color: .white, size: topWallSize)
        topWallNode.position = CGPoint(x: 0.5 * size.width, y: size.height - 25)
        topWallNode.physicsBody = SKPhysicsBody(rectangleOf: topWallNode.size)
        topWallNode.physicsBody?.isDynamic = false
        addChild(topWallNode)
        
        let leftWallNode = SKSpriteNode(color: .white, size: sideWallSize)
        leftWallNode.position = CGPoint(x: 25, y: 0.5 * size.height)
        leftWallNode.physicsBody = SKPhysicsBody(rectangleOf: leftWallNode.size)
        leftWallNode.physicsBody?.isDynamic = false
        addChild(leftWallNode)
        
        let rightWallNode = SKSpriteNode(color: .white, size: sideWallSize)
        rightWallNode.position = CGPoint(x: size.width - 25, y: 0.5 * size.height)
        rightWallNode.physicsBody = SKPhysicsBody(rectangleOf: rightWallNode.size)
        rightWallNode.physicsBody?.isDynamic = false
        addChild(rightWallNode)
        
        physicsWorld.gravity = .zero
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
    
    private func touchLocation(movedTo point: CGPoint) {
        guard let paddleNode,
              let lastTouchLocation else { return }
        
        let positionUpdateX = paddleNode.position.x + point.x - lastTouchLocation.x
        let destinationX = positionUpdateX.clamp(
            min: paddleNode.size.width * 0.5,
            max: size.width - paddleNode.size.width * 0.5)
        paddleNode.position = CGPoint(x: destinationX, y: paddleNode.position.y)
        self.lastTouchLocation = point
    }
}
