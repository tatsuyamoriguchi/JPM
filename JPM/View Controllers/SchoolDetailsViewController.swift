//
//  SchoolDetailsViewController.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 11/2/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class SchoolDetailsViewController: UIViewController {

    var testName: String = ""
    
    
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolNameLabel.text = testName

        print("testName 3: \(testName)")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
