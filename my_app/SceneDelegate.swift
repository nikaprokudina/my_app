//
//  SceneDelegate.swift
//  my_app
//
//  Created by Nika on 10/6/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return } //return if nil
        let window = UIWindow(windowScene: windowScene)
        let factory = GameTableViewControllerFactory()
        let viewcontroller = factory.build()
        window.rootViewController = viewcontroller
        window.makeKeyAndVisible()
        self.window = window
    }


}

