//
//  SchoolDetailsViewController.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 11/2/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit
//import MessageUI


class SchoolDetailsViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Properties
    var schoolObj: SchoolResults? = nil
    var academicOppo: String = ""
    var name4Iteration: String = ""
    
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var eMail: UILabel!
    @IBOutlet weak var webSite: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    @IBOutlet weak var attendanceRate: UILabel!
    @IBOutlet weak var academicOpportunities: UITextView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolName.text = schoolObj?.school_name
        phoneNumber.text = "ClickToCall 📱 \(schoolObj?.phone_number ?? "N/A")"
        eMail.text = "ClickToSend 📧 \(schoolObj?.school_email ?? "N/A")"
        webSite.text = "ClickToOpen \(schoolObj?.website ?? "N/A")"
        startTime.text = "Start Time: \(schoolObj?.start_time ?? "N/A")"
        endTime.text = "End Time: \(schoolObj?.end_time ?? "N/A")"
        
        // Convert college_career_rate String to Int in percentage for display
        if let doubleRate = schoolObj?.attendance_rate?.toDouble() {
            let rate = Int(doubleRate * 100)
            attendanceRate.text = "Attendance Rate: \(rate)%"
        }
        
        // Merge academic opportunity text strings
        let tempArray = [schoolObj?.academicopportunities1, schoolObj?.academicopportunities2, schoolObj?.academicopportunities3, schoolObj?.academicopportunities4, schoolObj?.academicopportunities5]
        
        for i in tempArray {
            if i != nil {
                academicOppo.append(i!)
                academicOppo.append("\n\n")
            }
        }
        
        academicOpportunities.text = academicOppo
        

        // When phone number is tapped, make a phone call to the number (unable to test on Simulator.)
        if schoolObj?.phone_number != nil {
            phoneNumber.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.phoneNumberLabelTap))
            tap.delegate = self
            phoneNumber.addGestureRecognizer(tap)
        }
        // Send email when email address is tapped (Unale to test on Simulator since no email set up)
        if schoolObj?.school_email != nil {
            eMail.isUserInteractionEnabled = true
            let tapEmail = UITapGestureRecognizer(target: self, action: #selector(self.sendEmailLabelTap))
            tapEmail.delegate = self
            eMail.addGestureRecognizer(tapEmail)
        }
        // Open browser with school url when web site url is tapped
        if schoolObj?.website != nil {
            webSite.isUserInteractionEnabled = true
            let tapWebsite = UITapGestureRecognizer(target: self, action: #selector(self.webSiteLabelTap))
            tapWebsite.delegate = self
            webSite.addGestureRecognizer(tapWebsite)
        }
    }
}


//extension SchoolDetailsViewController: MFMailComposeViewControllerDelegate {
//    @objc func phoneNumberLabelTap() {
//        //        print("phoneNumber: \(schoolObj?.phone_number)")
//        let phoneUrl = URL(string: "telprompt:\(schoolObj?.phone_number ?? "")")!
//        
//        if(UIApplication.shared.canOpenURL(phoneUrl)) {
//            
//            UIApplication.shared.open(phoneUrl)
//        }
//        else {
//            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                switch action.style{
//                    
//                case .cancel:
//                    print("cancel")
//                    
//                case .destructive:
//                    print("destructive")
//                    
//                default:
//                    print("default")
//                    
//                }
//            }))
//            
//        }
//    }
//    
//    @objc func sendEmailLabelTap() {
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setToRecipients(["you@yoursite.com"])
//            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
//            
//            present(mail, animated: true)
//        } else {
//            // show failure alert
//        }
//    }
//    
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true)
//    }
//    
//    
//    @objc func webSiteLabelTap() {
//        
//        
//        if let firstURLString = schoolObj?.website {
//            let urlString = "https://" + firstURLString
//            if let url = URL(string: urlString) {
//                
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                
//            }
//            
//            
//        }
//    }
//}


