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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, CAAnimationDelegate, CALayerDelegate {

    // Declare a layer variable for animation
    var mask: CALayer?

    // Instantiate Location Manager to manage a user's location data
    // If console returns an error: "libMobileGestalt MobileGestalt.c:1647: Could not retrieve region info".
    // add a location to your Simulator. Simulator menu: Features/Location/Custom Location
    let locationManager = CLLocationManager()

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var college_career_rateLabel: UILabel!
    @IBOutlet weak var total_studentsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var school_nameButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // When school name label is tapped, segue to SchoolDetailsVC
    var schoolName: String = ""
    @IBAction func schoolTapped(_ sender: UIButton) {
        
        schoolName = tappedSchool?.school_name ?? "No school name available"
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "Segue2Details", sender: self)
        }
    }
    
    var sections = [String]()
    var dataSource = [String:[SchoolResults]]()
    // To temporally hold school detail information when TableViewCell is tapped and pass it to details view
    // See tableView(didSelectRowAt
    var tappedSchool: SchoolResults? = nil

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Tap School Name for Details"
        school_nameButton.setTitle("Tap for Details", for: .normal)
        
        
        // Opening Animation
        maskView()
        animate()

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
        
        // Access API to get school data
        self.getData(url: EndPoint().endPoint)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SchoolDetailsViewController
        vc.schoolObj = tappedSchool
    }
}

extension ViewController {
    // Core Location, MapKit
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
    }
}

extension ViewController  {
    
    // MARK: - ANIMATION
    // Create a layer
    func maskView() {
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "JPM-logo")!.cgImage
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        view.layer.mask = mask
    }
    
    // Do Animation
    func animate() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1
        
        keyFrameAnimation.duration = 2
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut), CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)]
        
        let initialBounds = NSValue(cgRect: mask!.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 5, height: 5))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        keyFrameAnimation.values = [initialBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        self.mask!.add(keyFrameAnimation, forKey: "bounds")
        
    }
    
    // Remove sublayer after animation is done to expose login view
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        mask?.removeFromSuperlayer()
    }
}

