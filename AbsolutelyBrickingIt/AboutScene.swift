//
// AboutScene.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 15/08/2024.
// 

import SpriteKit

protocol AboutSceneCoordinator: AnyObject {
    func aboutSceneScreenTapped(_ scene: AboutScene)
}

class AboutScene: SKScene {
    
    weak var coordinator: AboutSceneCoordinator?
    
    override func didMove(to view: SKView) {
        let backgroundNode = SKSpriteNode(imageNamed: "background.menu")
        backgroundNode.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        addChild(backgroundNode)
        
        let logoNode = SKSpriteNode(imageNamed: "logo")
        logoNode.position = CGPoint(x: 0.5 * size.width, y: 0.8 * size.height)
        addChild(logoNode)
        
        let textNode = SKSpriteNode(imageNamed: "text.about")
        textNode.position = CGPoint(x: 0.5 * size.width, y: 0.4 * size.height)
        addChild(textNode)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        coordinator?.aboutSceneScreenTapped(self)
    }
}

