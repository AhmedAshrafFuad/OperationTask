//
//  SceneDelegate.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        navigationController.viewControllers = [OperationsVC()]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }



    func sceneDidDisconnect(_ scene: UIScene) {
        LocationService.shared.setLocationRegion()
    }
    
    

    
    
}

