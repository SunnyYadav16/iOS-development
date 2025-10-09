//
//  ViewController.swift
//  WA4_Yadav_1702
//
//  Created by Sunny Yadav on 10/6/25.
//

import UIKit

class ViewController: UIViewController {

    let mainScreen = MainScreenView()
    var contacts = [Contacts]()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Contacts"
        
        mainScreen.contactListTableView.delegate = self
        mainScreen.contactListTableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .add, target: self, action: #selector(onAddBarButtonTapped))
    }
    
    @objc func onAddBarButtonTapped() {
        let addProfileController = ProfileScreenViewController()
        addProfileController.delegate = self
        navigationController?.pushViewController(addProfileController, animated: true)
    }
    
    func delegateOnSaveContact(contact: Contacts){
        contacts.append(contact)
        mainScreen.contactListTableView.reloadData()
    }
    
    func delegateOnEditContact(contact: Contacts, at index: Int) {
        contacts[index] = contact
        mainScreen.contactListTableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath) as! ContactListTableViewCell
        cell.labelName.text = contacts[indexPath.row].name
        if let email = contacts[indexPath.row].email{
            cell.labelEmail.text = email
        }
        if let phone = contacts[indexPath.row].phoneNumber, let phoneType = contacts[indexPath.row].phoneType{
            cell.labelPhone.text = "\(phone) (\(phoneType))"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contacts[indexPath.row]
        
        let displayScreenController = DisplayScreenViewController()
        displayScreenController.contact = selectedContact
        displayScreenController.contactIndex = indexPath.row
        displayScreenController.delegate = self
        
        navigationController?.pushViewController(displayScreenController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
