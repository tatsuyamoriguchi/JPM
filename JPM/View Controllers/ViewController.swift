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

class ViewController: UIViewController, CLLocationManagerDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var school_nameLabel: UILabel!
    @IBOutlet weak var college_career_rateLabel: UILabel!
    @IBOutlet weak var total_studentsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var schoolMapView: MKMapView!
    
    
    
//    var schoolList = [SchoolResults]()
//    var neighbCount: Int = 0
//
    
    var sections = [String]()
    var dataSource = [String:[SchoolResults]]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 // Instantiate Location Manager to manage a user's location data
  let locationManager = CLLocationManager()
        
      // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.getData(url: EndPoint().endPoint)
    }

}

// MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
           
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .systemTeal
        
        print("sections[section]: \(sections[section])")
        return sections[section]
    }
    


    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionNeighborhood = sections[section]
        return dataSource[sectionNeighborhood]?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .systemIndigo
        headerLabel.textColor = .white
        headerLabel.text = sections[section]
        return headerLabel
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let sectionNeighborhood = sections[indexPath.section]
        let item = dataSource[sectionNeighborhood]![indexPath.row]
        
        cell.textLabel?.text = item.school_name
        if let nameString = item.neighborhood {
            cell.detailTextLabel?.text = nameString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionNeighborhood = sections[indexPath.section]
        let item = dataSource[sectionNeighborhood]![indexPath.row]
        
        school_nameLabel.text = item.school_name
        
        
        locationLabel.text = removeAfter(char: "(", word: item.location)
        
        // Convert college_career_rate String to Int in percentage for display
        if let doubleRate = item.college_career_rate?.toDouble() {
            let rate = Int(doubleRate * 100)
            college_career_rateLabel.text = "College Career Rate: \(rate)%"
        }
        
        if let total = item.total_students {
            total_studentsLabel.text = "Total Students: \(total)"
        }
        
        
        
    }
}

extension String {
    func toDouble() -> Double {
        let nsString = self as NSString
        return nsString.doubleValue
    }
}


extension ViewController {
    // Remove characteres after 'char' from 'word'
    // Use it to omit location data from location address
    // i.e. 2474 Crotona Avenue, Bronx NY 10458 (40.855392, -73.882487)
    // -> 2474 Crotona Avenue, Bronx NY 10458
    func removeAfter(char: String, word: String) -> String {
        var string: String = ""
        if let index = word.range(of: char)?.lowerBound {
            let substring = word[..<index]
            string = String(substring)
        }
        return string
    }
}

extension ViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        
    }
}
