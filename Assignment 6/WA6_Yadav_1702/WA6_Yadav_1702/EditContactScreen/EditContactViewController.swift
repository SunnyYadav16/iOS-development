//
//  EditContactViewController.swift
//  Working with APIs
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit
import Alamofire

class EditContactViewController: UIViewController {
    
    let editView = EditContactView()
    var originalContact: Contact!
    
    override func loadView() {
        view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Contact"
        
        populateFields()
        
        editView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        
        hideKeyboardOnTapOutside()
    }
    
    func hideKeyboardOnTapOutside(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    func populateFields() {
        editView.nameTextField.text = originalContact.name
        editView.emailTextField.text = originalContact.email
        editView.phoneTextField.text = String(originalContact.phone)
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonTapped() {
        // Validate Name
        guard let name = editView.nameTextField.text,
              !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter a name.")
            return
        }
        
        // Validate Email
        guard let email = editView.emailTextField.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter an email.")
            return
        }
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidEmail(trimmedEmail) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        
        // Validate Phone
        guard let phoneText = editView.phoneTextField.text,
              !phoneText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter a phone number.")
            return
        }
        
        let trimmedPhone = phoneText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidPhoneNumber(trimmedPhone) {
            showAlert(title: "Invalid Phone", message: "Please enter a valid 10-digit phone number")
            return
        }
        
        guard let phoneInt = Int(trimmedPhone) else {
                showAlert(title: "Invalid Phone", message: "Phone number must be numeric")
                return
            }
        
        let updatedContact = Contact(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            email: trimmedEmail,
            phone: phoneInt
        )
        
        deleteAndAddContact(oldContact: originalContact, newContact: updatedContact)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPhoneNumber(_ phone: String) -> Bool {
           let phoneDigits = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
           return phoneDigits.count == 10
       }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func deleteAndAddContact(oldContact: Contact, newContact: Contact) {
        guard let deleteUrl = URL(string: APIConfigs.baseURL + "delete") else { return }
        
        // Delete the old contact
        AF.request(deleteUrl, method: .get,
                   parameters: ["name": oldContact.name],
                   encoding: URLEncoding.queryString)
            .responseString { [weak self] response in
                switch response.result {
                case .success(_):
                    if let statusCode = response.response?.statusCode,
                       statusCode >= 200 && statusCode < 300 {
                        // Only adding the new contact after successful deletion
                        self?.addUpdatedContact(contact: newContact)
                    } else {
                        self?.showAlert(title: "Error", message: "Failed to update contact")
                    }
                case .failure(let error):
                    print("Error deleting contact: \(error)")
                    self?.showAlert(title: "Error", message: "Failed to update contact")
                }
            }
    }
    
    func addUpdatedContact(contact: Contact) {
        guard let addUrl = URL(string: APIConfigs.baseURL + "add") else { return }
        
        AF.request(addUrl, method: .post,
                   parameters: [
                    "name": contact.name,
                    "email": contact.email,
                    "phone": contact.phone
                   ])
            .responseString { [weak self] response in
                switch response.result {
                case .success(_):
                    if let statusCode = response.response?.statusCode,
                       statusCode >= 200 && statusCode < 300 {
                        NotificationCenter.default.post(
                            name: .editContact,
                            object: nil
                        )
                        
                        self?.navigationController?.popToRootViewController(animated: true)
                    } else {
                        self?.showAlert(title: "Error", message: "Failed to save updated contact")
                    }
                case .failure(let error):
                    print("Error adding contact: \(error)")
                    self?.showAlert(title: "Error", message: "Failed to save updated contact")
                }
            }
    }
}
