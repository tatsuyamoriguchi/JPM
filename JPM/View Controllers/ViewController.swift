//
//  ViewController.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 10/31/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    

    // Instantiate Location Manager to manage a user's location data
    // If console returns an error: "libMobileGestalt MobileGestalt.c:1647: Could not retrieve region info".
    // add a location to your Simulator. Simulator menu: Features/Location/Custom Location
    let locationManager = CLLocationManager()
    let latitude: Double = 0.0
    let longitude: Double = 0.0
    let descript: String = ""

    




    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var school_nameLabel: UILabel!
    @IBOutlet weak var college_career_rateLabel: UILabel!
    @IBOutlet weak var total_studentsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
//    var schoolList = [SchoolResults]()
//    var neighbCount: Int = 0
//
    
    var sections = [String]()
    var dataSource = [String:[SchoolResults]]()
    
 
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate { mapView.setCenter(coor, animated: true) }
        
       
        //GetMap().openMapForPlace(lat: 37.785834, long: -122.406417, placeName: "Home")
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.getData(url: EndPoint().endPoint)
    }

}


extension ViewController {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        let location = locations.last {_ in
//        let center = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//            self.mapView.setRegion(region, animated: true)
//      }
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
