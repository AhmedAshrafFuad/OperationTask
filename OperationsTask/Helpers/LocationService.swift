//
//  LocationService.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 28/12/2020.
//

import CoreLocation
import UIKit

class LocationService: NSObject, CLLocationManagerDelegate {

    static let shared = LocationService()
    var locationManager = CLLocationManager()
//    var significatLocationManager = CLLocationManager()
    var currentLocation: CLLocation!
//    var timer = Timer()
//    var bgTask = UIBackgroundTaskIdentifier.invalid

   
    
  
    override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
    }

   
    func startMonitoringLocation() {
        locationManager.startMonitoringSignificantLocationChanges()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last!
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        fireLocalNotification( body: "you left the specific region")
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        fireLocalNotification( body: "you entered the specific region")
    }
    
    func setLocationRegion(){
        guard let _ = currentLocation else {
            return
        }
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude), radius: 10, identifier: "currentLocationCircle")
        region.notifyOnExit = true
        region.notifyOnEntry = true
        locationManager.startMonitoring(for: region)
    }
    
    
    func fireLocalNotification(body: String){
        let content = UNMutableNotificationContent()
        content.title = "Location chang alertion"
        content.subtitle = body
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "locationUpdated", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    
    }
}
