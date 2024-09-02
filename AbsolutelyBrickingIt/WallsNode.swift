//
// WallsNode.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 02/09/2024.
// 

import SpriteKit

class WallsNode: SKNode {
    
    init(sceneSize: CGSize) {
        let hWallSize = CGSize(width: sceneSize.width, height: 50)
        let vWallSize = CGSize(width: 50, height: sceneSize.height)
        
        let topWallPosition = CGPoint(x: 0.5 * sceneSize.width, y: sceneSize.height + 0.5 * hWallSize.height)
        let leftWallPosition = CGPoint(x: -0.5 * vWallSize.width, y: 0.5 * sceneSize.height)
        let rightWallPosition = CGPoint(x: sceneSize.width + 0.5 * vWallSize.width, y: 0.5 * sceneSize.height)
        
        super.init()
        
        addWallNode(size: hWallSize, position: topWallPosition)
        addWallNode(size: vWallSize, position: leftWallPosition)
        addWallNode(size: vWallSize, position: rightWallPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WallsNode {
    
    func addWallNode(size: CGSize, position: CGPoint) {
        let wallNode = SKSpriteNode(color: .white, size: size)
        wallNode.name = "wall"
        wallNode.position = position
        wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallNode.size)
        wallNode.physicsBody?.categoryBitMask = PhysicsCategory.wall
        wallNode.physicsBody?.isDynamic = false
        addChild(wallNode)
    }
}
