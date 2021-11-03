//
//  TableViewController.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 11/2/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

// MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
           
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .systemTeal
        
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
    
    // Show school location on map and selected school data when tableview cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionNeighborhood = sections[indexPath.section]
        let item = dataSource[sectionNeighborhood]![indexPath.row]
        
        // Display school name on UIButton
        school_nameButton.setTitle(item.school_name, for: .normal)
        // Remove location data at the end of address
        locationLabel.text = Helper().removeAfter(char: "(", word: item.location)
        
        // Convert college_career_rate String to Int in percentage for display
        if let doubleRate = item.college_career_rate?.toDouble() {
            let rate = Int(doubleRate * 100)
            college_career_rateLabel.text = "College Career Rate: \(rate)%"
        }
        
        if let total = item.total_students {
            total_studentsLabel.text = "Total Students: \(total)"
        }
        
        // show tapped school location in map
        let lati = Double(item.latitude!) ?? 0.0
        let longi = Double(item.longitude!) ?? 0.0
        let locValue = CLLocationCoordinate2D(latitude: lati, longitude: longi)
        mapView.setCenter(locValue, animated: true)
        
        // Add annotation to school location, tap the red pin on map to see the annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = item.school_name
        annotation.subtitle = "Subway: \(item.subway ?? "N/A"), \nBus: \(item.bus ?? "N/A")"
        mapView.addAnnotation(annotation)
        
        // To hold school detail data for detail view when school name UILabel is tapped
        tappedSchool = item
    }
}
