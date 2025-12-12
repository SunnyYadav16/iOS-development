//
//  ContactDetailsViewController.swift
//  Working with APIs
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit
import Alamofire

class ContactDetailsViewController: UIViewController {
    
    let detailsView = ContactDetailsView()
    var contact: Contact!
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contact Details"
        
        let deleteButton = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(deleteButtonTapped)
        )
        
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped)
        )
        
        navigationItem.rightBarButtonItems = [deleteButton, editButton]
        
        displayContactDetails()
    }
    
    func displayContactDetails() {
        detailsView.nameValueLabel.text = contact.name
        detailsView.emailValueLabel.text = contact.email
        detailsView.phoneValueLabel.text = String(contact.phone)
    }
    
    @objc func editButtonTapped() {
        let editViewController = EditContactViewController()
        editViewController.originalContact = contact
        navigationController?.pushViewController(editViewController, animated: true)
    }
    
    @objc func deleteButtonTapped() {

        let alert = UIAlertController(
            title: "Delete Contact",
            message: "Are you sure you want to delete \(contact.name)?",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteContact()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func deleteContact() {
        guard let url = URL(string: APIConfigs.baseURL + "delete") else { return }
        
        AF.request(url, method: .get, parameters: ["name": contact.name], encoding: URLEncoding.queryString)
            .responseString { response in
                switch response.result {
                case .success(_):
                    if let statusCode = response.response?.statusCode,
                       statusCode >= 200 && statusCode < 300 {
                        NotificationCenter.default.post(
                            name: .deleteContact,
                            object: nil
                        )
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    print("Error deleting contact: \(error)")
                    self.showErrorAlert()
                }
            }
    }
        
        func showErrorAlert() {
            let alert = UIAlertController(
                title: "Error",
                message: "Failed to delete contact. Please try again.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
}
