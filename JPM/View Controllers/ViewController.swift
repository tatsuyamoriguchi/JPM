//
//  ViewController.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 10/31/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetApiCall().getData(url: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
    }

    
    

}

