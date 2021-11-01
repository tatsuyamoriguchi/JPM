//
//  GetApiCall.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 10/31/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation

class GetApiCall {
    
    func getData(url: String)  {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("X-App-Token", forHTTPHeaderField: "npmYdShIyZkiNj3a7vKmV8rXZ")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in

            do {
            
                let response = try JSONDecoder().decode([SchoolResults].self, from: data!)
                
                for i in response {
                    print(i.school_name)
                }
                
                
            } catch {
                print("hello error: \(error)")
            }
        })
        
        task.resume()
    }
}
