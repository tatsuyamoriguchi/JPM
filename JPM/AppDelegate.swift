//
//  AppDelegate.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 10/31/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // to get the description use GLGeocoder, which converts coordinates into addresses or palce names
    static let geoCoder = CLGeocoder()

    //let center = UNUserNotificationCenter.current()
    // Instantiate Location Manager to manage a user's location data
    let locationManager = CLLocationManager()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Acknoledge a user to allow the app to access location data
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        
        return true
    }

    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: CLLocationManagerDelegate {
    
    // Callback from CLLocationManager when the new visit is recorderd and provides you with a CLVisit
    // CLVisit properties:
    // arrivalDate, departureDate, coordinate, horizontalAccuracy
//    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
//        // create CLLocation from the coordinates of CLVisit
//        let clLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
//
//        // Get location description here.
//        let userLocation = clLocation.coordinate
//        print("userLocation: \(userLocation)")

        
          
        
        
        // Use distance to measure between user's and a school location in ViewController
//    clLocation.distance(from: <#T##CLLocation#>)
        
        // Ask GeoCode to get placemarks from the location, take the first placemark
//        AppDelegate.geoCoder.reverseGeocodeLocation(clLocation) {
//            placemarks, _ in
//            if let place = placemarks?.first {
//                let description = "\(place)"
//                self.newVisitReceived(visit, description: description)
//            }
//
//        }
    
    
    
//    func newVisitReceived(_ visit: CLVisit, description: String ) {
//        init(_ location: CLLocationCoordinate2D, date: Date, descriptionString: String)
//
//        let location = Location(visit: visit, descriptionString: description)
//
//        // Create notification content.
//        let content = UNMutableNotificationContent()
//
//        content.title = "New location reached"
//        content.body = "location.description"
//        content.sound = .default
//
//        center.add(request, withCompletionHandler: nil)
//
//        // Save location to disk here
//
//    }
}
