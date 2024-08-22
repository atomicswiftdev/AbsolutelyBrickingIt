//
// GameCompleteScene.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 22/08/2024.
// 

import SpriteKit

protocol GameCompleteSceneCoordinator: AnyObject {
    func gameCompleteSceneMenuTapped(_ scene: GameCompleteScene)
    func gameCompleteScenePlayTapped(_ scene: GameCompleteScene)
}

class GameCompleteScene: SKScene {
    
    weak var coordinator: GameCompleteSceneCoordinator?
    
    private var menuNode: SKSpriteNode?
    private var playNode: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let backgroundNode = SKSpriteNode(imageNamed: "background.menu")
        backgroundNode.position = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        addChild(backgroundNode)
        
        let gameOverNode = SKSpriteNode(imageNamed: "text.game-complete")
        gameOverNode.position = CGPoint(x: 0.5 * size.width, y: 0.75 * size.height)
        addChild(gameOverNode)
        
        let menuNode = SKSpriteNode(imageNamed: "button.menu")
        menuNode.position = CGPoint(x: 0.5 * size.width, y: 0.32 * size.height)
        addChild(menuNode)
        self.menuNode = menuNode
        
        let playNode = SKSpriteNode(imageNamed: "button.play-again")
        playNode.position = CGPoint(x: 0.5 * size.width, y: 0.2 * size.height)
        addChild(playNode)
        self.playNode = playNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = touch.location(in: self)
            
            if playNode?.contains(point) == true {
                coordinator?.gameCompleteScenePlayTapped(self)
            } else if menuNode?.contains(point) == true {
                coordinator?.gameCompleteSceneMenuTapped(self)
            }
        }
    }
}
