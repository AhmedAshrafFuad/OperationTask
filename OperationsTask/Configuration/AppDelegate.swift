//
//  AppDelegate.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
      
        FirebaseApp.configure()
        application.registerForRemoteNotifications()
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
    

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
   
        DispatchQueue.main.async {
            let application = UIApplication.shared
            let backgroundId = application.beginBackgroundTask {}
            if backgroundId != .invalid {
                application.endBackgroundTask(backgroundId)
                completionHandler(.failed)
            }
            self.changeFBValue { (result) in
                completionHandler(result)
            }
        }
    }
    
    
    func changeFBValue(completion: @escaping(UIBackgroundFetchResult)->()){
        let url = URL(string: "https://spry-tesla-252013-default-rtdb.firebaseio.com/.json")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var task: URLSessionDataTask? = nil
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            let requestBody = try? JSONSerialization.data(withJSONObject: ["TaskPerformed":true], options: [])
            guard requestBody != nil  else {
                completion(.failed)
                return
            }
            request.httpBody = requestBody
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(.newData)
            })
        }
        task?.resume()
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







