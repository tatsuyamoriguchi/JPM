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
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("X-App-Token", forHTTPHeaderField: "npmYdShIyZkiNj3a7vKmV8rXZ")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if error != nil {
                print("Error: \(String(describing: error))")
            } else {
            
            do {
                
                let result = try JSONDecoder().decode([SchoolResults].self, from: data!)
                self.dataSource = Dictionary(grouping: result, by: {($0.neighborhood ?? "No neighborhood info")})
                self.sections = self.dataSource.keys.sorted()

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("error: \(error)")
            }
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
