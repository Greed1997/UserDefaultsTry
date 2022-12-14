//
//  SceneDelegate.swift
//  UserDefaultsTextTry
//
//  Created by Александр on 03.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible() // делает экран window ключевым и видимым
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
    }
    
}

