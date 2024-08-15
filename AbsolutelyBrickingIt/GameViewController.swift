//
// GameViewController.swift
// AbsolutelyBrickingIt
// 
// Created by atomicswiftdev on 10/08/2024.
// 

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as? SKView else { return }
        
        let scene = MenuScene(size: CGSize(width: 375.0, height: 667.0))
        scene.coordinator = self
        scene.scaleMode = .resizeFill
        
        view.ignoresSiblingOrder = false
        view.showsFPS = true
        view.showsNodeCount = true
        view.presentScene(scene)
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

extension GameViewController: MenuSceneCoordinator {
    
    func menuSceneAboutTapped(_ scene: MenuScene) {
        guard let view = self.view as? SKView else { return }
        
        let scene = AboutScene(size: CGSize(width: 375.0, height: 667.0))
        scene.coordinator = self
        scene.scaleMode = .resizeFill
        
        view.presentScene(scene)
    }
    
    func menuScenePlayTapped(_ scene: MenuScene) {
        guard let view = self.view as? SKView else { return }
        
        let scene = GameScene(size: CGSize(width: 375.0, height: 667.0))
        scene.scaleMode = .resizeFill
        
        view.presentScene(scene)
    }
}

extension GameViewController: AboutSceneCoordinator {
    
    func aboutSceneScreenTapped(_ scene: AboutScene) {
        guard let view = self.view as? SKView else { return }
        
        let scene = MenuScene(size: CGSize(width: 375.0, height: 667.0))
        scene.coordinator = self
        scene.scaleMode = .resizeFill
        
        view.presentScene(scene)
    }
}
