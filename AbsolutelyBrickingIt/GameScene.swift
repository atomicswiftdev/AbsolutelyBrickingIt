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
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        coordinator?.gameSceneScreenTapped(self)
    }
}
