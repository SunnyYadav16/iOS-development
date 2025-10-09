//
//  DisplayScreenViewController.swift
//  WA4_Yadav_1702
//
//  Created by Sunny Yadav on 10/7/25.
//

import UIKit

class DisplayScreenViewController: UIViewController {

    var displayScreen = DisplayScreenView()
    var contact: Contacts!
    var contactIndex: Int!
    var delegate: ViewController!
    
    override func loadView() {
        view = displayScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .edit, target: self, action: #selector(onEditButtonTapped))
        
        loadContactData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        contact = delegate.contacts[contactIndex]
        loadContactData()
    }
    
    func loadContactData() {
        displayScreen.nameLabel.text = contact.name
        displayScreen.emailLabel.text = "Email: \(contact.email ?? "")"
        displayScreen.phoneLabel.text = "Phone: \(contact.phoneNumber ?? "") (\(contact.phoneType ?? ""))"
        displayScreen.addressHeaderLabel.text = "Address:"
        displayScreen.addressLabel.text = contact.address
        displayScreen.cityStateLabel.text = contact.cityState
        
        if let zipCode = contact.zipCode {
            displayScreen.zipCodeLabel.text = String(zipCode)
        }
    }
    
    @objc func onEditButtonTapped() {
        let editProfileController = ProfileScreenViewController()
        editProfileController.contactToEdit = contact
        editProfileController.editIndex = contactIndex
        editProfileController.delegate = delegate
        navigationController?.pushViewController(editProfileController, animated: true)
    }

}
