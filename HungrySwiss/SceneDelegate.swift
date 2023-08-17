//
//  SceneDelegate.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - UIWindowSceneDelegate
    
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        
        self.window = window
    }


}

