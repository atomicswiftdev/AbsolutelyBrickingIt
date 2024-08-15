//
// AboutScene.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 15/08/2024.
// 

import SpriteKit

class AboutScene: SKScene {
    
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
}

