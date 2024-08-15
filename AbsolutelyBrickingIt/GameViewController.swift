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
    
    func gameSceneScreenTapped(_ scene: GameScene) {
        present(scene: menuScene)
    }
}
