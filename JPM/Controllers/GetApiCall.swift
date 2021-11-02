//
//  GetApiCall.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 10/31/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation

extension ViewController {
    
    
    
    func getData(url: String) {
        
//        var schools = [SchoolResults]()
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("X-App-Token", forHTTPHeaderField: "npmYdShIyZkiNj3a7vKmV8rXZ")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
                
                let result = try JSONDecoder().decode([SchoolResults].self, from: data!)
                self.dataSource = Dictionary(grouping: result, by: {($0.neighborhood ?? "No neighborhood info")})
                self.sections = self.dataSource.keys.sorted()

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
//                for i in response {
//                    schools.append(SchoolResults(dbn: i.dbn, school_name: i.school_name, overview_paragraph: i.overview_paragraph, academicopportunities1: i.academicopportunities1, academicopportunities2: i.academicopportunities2, academicopportunities3: i.academicopportunities3, academicopportunities4: i.academicopportunities4, academicopportunities5: i.academicopportunities5, neighborhood: i.neighborhood, location: i.location, phone_number: i.phone_number, school_email: i.school_email, website: i.website, subway: i.subway, bus: i.bus, total_students: i.total_students, start_time: i.start_time, end_time: i.end_time, graduation_rate: i.graduation_rate, attendance_rate: i.attendance_rate, college_career_rate: i.college_career_rate, latitude: i.latitude, longitude: i.longitude ))
//                }

        
                
//                schools = schools.sorted { $0.neighborhood! < $1.neighborhood! }
                
//                DispatchQueue.main.async {
//                    //self.neighborData = self.neighborDict(data: schools)
//                    //print("self.neighborData: \(self.neighborData)")
//                    self.neighbCount = self.countNeighborhood(data: schools)
//                    self.schoolList = schools
//                    self.tableView.reloadData()
//
//                }
                
                
                
            } catch {
                print("hello error: \(error)")
            }
        })
        task.resume()
        
    }
    
    
    
    
    // Generate school list per neighborhood
    func countNeighborhood(data: [SchoolResults]) -> Int {
        
        var count: Int = 0
        var dataSet = Set<String>()
        
        for i in data {
            
            if i.neighborhood != nil || i.neighborhood != "" {
                
                dataSet.insert(i.neighborhood!)
            } else {
                dataSet.insert("No Neighborhood")
            }
        }

        count = dataSet.count
        return count
    }
}
