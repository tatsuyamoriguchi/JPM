//
//  SchoolDetailsViewController.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 11/2/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class SchoolDetailsViewController: UIViewController {
    
    var schoolObj: SchoolResults? = nil
    var academicOppo: String = ""
    var name4Iteration: String = ""
    
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var eMail: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var attendanceRate: UILabel!
    
    @IBOutlet weak var academicOpportunities: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolName.text = schoolObj?.school_name
        phoneNumber.text = schoolObj?.phone_number
        eMail.text = schoolObj?.school_email
        startTime.text = schoolObj?.start_time
        endTime.text = schoolObj?.end_time
        attendanceRate.text = schoolObj?.attendance_rate
        
        
        
        academicOppo.append(contentsOf: schoolObj?.academicopportunities1 ?? "")
        academicOppo.append(contentsOf: schoolObj?.academicopportunities2 ?? "")
        academicOppo.append(contentsOf: schoolObj?.academicopportunities3 ?? "")
        academicOppo.append(contentsOf: schoolObj?.academicopportunities4 ?? "")
        academicOppo.append(contentsOf: schoolObj?.academicopportunities5 ?? "")
        
        academicOpportunities.text = academicOppo
        
    }
    
    
}
