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
    @IBOutlet weak var college_career_rateLabel: UILabel!
    @IBOutlet weak var total_studentsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var school_nameButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var schoolName: String = ""
    @IBAction func schoolTapped(_ sender: UIButton) {
        
        schoolName = tappedSchool?.school_name ?? "No school name available"
        print("schoolName 1: \(schoolName)")
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "Segue2Details", sender: self)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SchoolDetailsViewController
        vc.schoolObj = tappedSchool
    }
    
    
//    var schoolList = [SchoolResults]()
//    var neighbCount: Int = 0
//
    
    var sections = [String]()
    var dataSource = [String:[SchoolResults]]()
    // To temporally hold school detail information when TableViewCell is tapped and pass it to details view
    // See tableView(didSelectRowAt
    var tappedSchool: SchoolResults? = nil
    
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
        
        // map configuration
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        // get user's current location to show it on map as default
        if let coor = mapView.userLocation.location?.coordinate { mapView.setCenter(coor, animated: true) }
        
     
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.getData(url: EndPoint().endPoint)
        
    
    }

}


extension ViewController {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        mapView.mapType = MKMapType.standard
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        // Add annotation to your current location
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "You are here"
        annotation.subtitle = "Current Location"
        mapView.addAnnotation(annotation)

        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

