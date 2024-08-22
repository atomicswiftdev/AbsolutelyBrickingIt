//
// GameViewController.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 10/08/2024.
// 

import UIKit
import SpriteKit

// MARK: - View controller interface

class GameViewController: UIViewController {
    
    private let sceneSize = CGSize(width: 375.0, height: 667.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        present(scene: menuScene)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - Private helper methods

private extension GameViewController {
    
    func setupView() {
        guard let view = self.view as? SKView else { return }
        
        view.ignoresSiblingOrder = false
        view.showsFPS = true
        view.showsNodeCount = true
        view.showsPhysics = true
    }
    
    func present(scene: SKScene) {
        guard let view = self.view as? SKView else { return }
        
        view.presentScene(scene)
    }
    
    var menuScene: MenuScene {
        let scene = MenuScene(size: sceneSize)
        scene.coordinator = self
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var aboutScene: AboutScene {
        let scene = AboutScene(size: sceneSize)
        scene.coordinator = self
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var gameScene: GameScene {
        let scene = GameScene(size: sceneSize)
        scene.coordinator = self
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var gameOverScene: GameOverScene {
        let scene = GameOverScene(size: sceneSize)
        scene.coordinator = self
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var gameCompleteScene: GameCompleteScene {
        let scene = GameCompleteScene(size: sceneSize)
        scene.coordinator = self
        scene.scaleMode = .resizeFill
        return scene
    }
}

// MARK: - Menu scene coordinator

extension GameViewController: MenuSceneCoordinator {
    
    func menuSceneAboutTapped(_ scene: MenuScene) {
        present(scene: aboutScene)
    }
    
    func menuScenePlayTapped(_ scene: MenuScene) {
        present(scene: gameScene)
    }
}

// MARK: - About scene coordinator

extension GameViewController: AboutSceneCoordinator {
    
    func aboutSceneScreenTapped(_ scene: AboutScene) {
        present(scene: menuScene)
    }
}

// MARK: - Game scene coordinator

extension GameViewController: GameSceneCoordinator {
    
    func gameSceneGameLost(_ scene: GameScene) {
        present(scene: gameOverScene)
    }
    
    func gameSceneGameWon(_ scene: GameScene) {
        present(scene: gameCompleteScene)
    }
}

// MARK: - Game Over scene coordinator

extension GameViewController: GameOverSceneCoordinator {
    
    func gameOverSceneMenuTapped(_ scene: GameOverScene) {
        present(scene: menuScene)
    }
    
    func gameOverScenePlayTapped(_ scene: GameOverScene) {
        present(scene: gameScene)
    }
}

// MARK: - Game Complete scene coordinator

extension GameViewController: GameCompleteSceneCoordinator {
    
    func gameCompleteSceneMenuTapped(_ scene: GameCompleteScene) {
        present(scene: menuScene)
    }
    
    func gameCompleteScenePlayTapped(_ scene: GameCompleteScene) {
        present(scene: gameScene)
    }
}
