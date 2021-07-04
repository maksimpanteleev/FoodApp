//
//  SceneDelegate.swift
//  FoodApp
//
//  Created by maxim panteleev on 19.06.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(frame: UIScreen.main.bounds)
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let loginVC = LoginVC()
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()   
    }
}

