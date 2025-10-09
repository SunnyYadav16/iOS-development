//
//  DisplayViewController.swift
//  WA3_Yadav_1702
//
//  Created by Sunny Yadav on 9/30/25.
//

import UIKit

class DisplayViewController: UIViewController {

    let displayView = DisplayView()
    
    override func loadView() {
        view = displayView
    }
    
    var userData: ViewController.UserDetails = ViewController.UserDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayView.nameLabel.text = "Name: \(userData.name ?? "N/A")"
        displayView.emailLabel.text = "Email: \(userData.email ?? "N/A")"
        
        if let phone = userData.phoneNumber, let type = userData.phoneType {
            displayView.phoneLabel.text = "Phone: \(phone) (\(type))"
            displayView.phoneImageView.image = UIImage(named: type.lowercased())
        } else {
            displayView.phoneLabel.text = "Phone: N/A"
        }
        
        displayView.addressLabel.text = "Address: \(userData.address ?? "N/A")"
        
        if let cityState = userData.cityState {
            displayView.cityStateLabel.text = "City, State: \(cityState)"
        } else {
            displayView.cityStateLabel.text = "City, State: N/A"
        }
        
        if let zip = userData.zipCode {
            displayView.zipLabel.text = "Zip: \(zip)"
        } else {
            displayView.zipLabel.text = "Zip: N/A"
        }
        
    }

}
