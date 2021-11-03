//
//  OpenURL.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 11/3/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation
import MessageUI

extension SchoolDetailsViewController: MFMailComposeViewControllerDelegate {
    @objc func phoneNumberLabelTap() {
        //        print("phoneNumber: \(schoolObj?.phone_number)")
        let phoneUrl = URL(string: "telprompt:\(schoolObj?.phone_number ?? "")")!
        
        if(UIApplication.shared.canOpenURL(phoneUrl)) {
            
            UIApplication.shared.open(phoneUrl)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                default:
                    print("default")
                    
                }
            }))
            
        }
    }
    
    @objc func sendEmailLabelTap() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            if let receipient = schoolObj?.school_email {
                mail.setToRecipients([receipient])
            }
            //mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    @objc func webSiteLabelTap() {
        if let firstURLString = schoolObj?.website {
            let urlString = "https://" + firstURLString
            if let url = URL(string: urlString) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
