//
//  ViewController.swift
//  WA5_Yadav_1702
//
//  Created by Sunny Yadav on 10/9/25.
//

import UIKit

class ViewController: UIViewController {

    let mainScreen = MainScreenView()
    var contacts = [Contacts]()
    var displayedContacts = [Contacts]()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Contacts"
        
        displayedContacts = contacts
        mainScreen.contactListTableView.separatorStyle = .none
        
        mainScreen.contactListTableView.delegate = self
        mainScreen.contactListTableView.dataSource = self
        
        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle"),
            style: .plain,
            target: self,
            action: nil
        )
        menuButton.menu = PhoneFilterMenu()
        
        let addContact = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onAddBarButtonTapped)
        )
                    
        navigationItem.rightBarButtonItems = [addContact, menuButton]
    }
    
    func PhoneFilterMenu() -> UIMenu {
        var menuItems = [UIAction]()
        
        let allAction = UIAction(
            title: "All",		
            handler: { _ in
                self.filterContacts(by: nil)
            }
        )
        menuItems.append(allAction)
                
        for type in Utilities.types {
            let action = UIAction(
                title: type,
                handler: { _ in
                    self.filterContacts(by: type)
                }
            )
            menuItems.append(action)
        }
        
        return UIMenu(title: "Filter by", children: menuItems)
    }
    
    @objc func onAddBarButtonTapped() {
        let addProfileController = ProfileScreenViewController()
        addProfileController.delegate = self
        navigationController?.pushViewController(addProfileController, animated: true)
    }
    
    func filterContacts(by phoneType: String?) {
        if let type = phoneType {
            let filteredContacts = contacts.filter { $0.phoneType == type }
            displayedContacts = filteredContacts
        } else {
            displayedContacts = contacts
        }
        
        mainScreen.contactListTableView.reloadData()
    }
    
    func delegateOnSaveContact(contact: Contacts){
        contacts.append(contact)
        displayedContacts = contacts
        mainScreen.contactListTableView.reloadData()
    }
    
    func delegateOnEditContact(contact: Contacts, at index: Int) {
        contacts[index] = contact
        displayedContacts = contacts
        mainScreen.contactListTableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath) as! ContactListTableViewCell
        let contact = displayedContacts[indexPath.row]
        cell.labelName.text = contact.name
        if let email = contact.email{
            cell.labelEmail.text = email
        }
        if let phone = contact.phoneNumber, let phoneType = contact.phoneType{
            cell.labelPhone.text = "\(phone) (\(phoneType))"
        }
        
        if let profileImage = contact.profileImage{
            cell.imageReceipt.image = profileImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = displayedContacts[indexPath.row]
        let actualIndex = contacts.firstIndex(where: { $0.name == selectedContact.name })!
        
        let displayScreenController = DisplayScreenViewController()
        displayScreenController.contact = selectedContact
        displayScreenController.contactIndex = actualIndex
        displayScreenController.delegate = self
        
        navigationController?.pushViewController(displayScreenController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
