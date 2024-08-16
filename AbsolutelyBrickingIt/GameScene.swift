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
    
    override func didMove(to view: SKView) {
        let backgroundNode = SKSpriteNode(imageNamed: "background.menu")
        backgroundNode.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        addChild(backgroundNode)
        
        let paddleNode = SKSpriteNode(imageNamed: "paddle")
        paddleNode.position = CGPoint(x: 0.5 * size.width, y: 0.1 * size.height)
        addChild(paddleNode)
        self.paddleNode = paddleNode
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
