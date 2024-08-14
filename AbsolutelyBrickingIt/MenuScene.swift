//
// MenuScene.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 13/08/2024.
// 

import SpriteKit

protocol MenuSceneCoordinator: AnyObject {
    func menuScenePlayTapped(_ menuScene: MenuScene)
}

class MenuScene: SKScene {
    
    weak var coordinator: MenuSceneCoordinator?
    
    private var playNode: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let backgroundNode = SKSpriteNode(imageNamed: "background.menu")
        backgroundNode.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        addChild(backgroundNode)
        
        let logoNode = SKSpriteNode(imageNamed: "logo")
        logoNode.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        addChild(logoNode)
        logoNode.run(.move(to: CGPoint(x: 0.5 * size.width, y: 0.8 * size.height), duration: 1.0))
        
        let aboutNode = SKSpriteNode(imageNamed: "button.about")
        aboutNode.position = CGPoint(x: 0.5 * size.width, y: 0.32 * size.height)
        addChild(aboutNode)
        
        let playNode = SKSpriteNode(imageNamed: "button.play")
        playNode.position = CGPoint(x: 0.5 * size.width, y: 0.2 * size.height)
        addChild(playNode)
        self.playNode = playNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = touch.location(in: self)
            
            if playNode?.contains(point) == true {
                coordinator?.menuScenePlayTapped(self)
            }
        }
    }
}
