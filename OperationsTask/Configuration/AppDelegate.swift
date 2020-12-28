//
//  AppDelegate.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        requestNotificationAuthorization()
        setRootVC()
        LocationService.shared.startMonitoringLocation()

        if let _ = launchOptions?[.location]{
            LocationService.shared.startMonitoringLocation()
        }
        
        
        return true
    }
    
        
    func requestNotificationAuthorization(){
        UNUserNotificationCenter.current().delegate = self
        let center = UNUserNotificationCenter.current()
           center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in

           }
    
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Success")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func setRootVC(){
        if let window = window{
            let nib = UINib(nibName: "OperationsVC", bundle:nil)
            window.rootViewController = nib.instantiate(withOwner: self, options: nil)[0] as? OperationsVC
        }
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    
}

