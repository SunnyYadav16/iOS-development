//
//  AddProfileScreenViewController.swift
//  WA4_Yadav_1702
//
//  Created by Sunny Yadav on 10/6/25.
//

import UIKit

class ProfileScreenViewController: UIViewController {

    let profileScreen = ProfileScreenView()
    var selectedPhoneType = "Cell"
    var delegate:ViewController!
    var contactToEdit: Contacts?
    var editIndex: Int?
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileScreen.phoneTypePicker.dataSource = self
        profileScreen.phoneTypePicker.delegate = self
        
        if contactToEdit != nil{
            title = "Edit a Contact"
            populateFields()
        } else {
            title = "Add a New Contact"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self, action: #selector(onSaveBarButtonTapped))
        
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
    
    @objc func onSaveBarButtonTapped() {
        guard let name = profileScreen.nameTextField.text,
              !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message:"Please enter your name.")
            return
        }

        guard let email = profileScreen.emailTextField.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your email")
            return
        }
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidEmail(trimmedEmail) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address")
            return
        }
        
        guard let phoneNumber = profileScreen.phoneNumberTextField.text,
              !phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your phone number")
            return
        }
        
        let trimmedPhone = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidPhoneNumber(trimmedPhone) {
            showAlert(title: "Invalid Phone", message: "Please enter a valid 10-digit phone number")
            return
        }
        
        if let cityState = profileScreen.cityStateTextField.text, !cityState.isEmpty {
            let trimmedCityState = cityState.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let parts = trimmedCityState.split(separator: ", ").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            
            if parts.count != 2 || parts[0].isEmpty || parts[1].isEmpty {
                showAlert(title: "Invalid Format", message: "Please enter both city and state (e.g., Boston, MA)")
                return
            }
        }
        
        var zipInt: Int? = nil
        let eligibleRange = 00001...99950
        if let zipText = profileScreen.zipCodeTextField.text, !zipText.isEmpty {
            guard let zip = Int(zipText), zipText.count == 5, eligibleRange.contains(zip) else {
                showAlert(title: "Invalid ZIP", message: "Please enter a valid 5-digit ZIP code")
                return
            }
            zipInt = zip
        }
        
        let contact = Contacts(name: name, email: email, phoneNumber: phoneNumber, phoneType: selectedPhoneType, address: profileScreen.addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), cityState: profileScreen.cityStateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), zipCode: zipInt)
        
        if let index = editIndex {
            delegate.delegateOnEditContact(contact: contact, at: index)
        } else {
            delegate.delegateOnSaveContact(contact: contact)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func populateFields() {
        guard let contact = contactToEdit else { return }
        
        profileScreen.nameTextField.text = contact.name
        profileScreen.emailTextField.text = contact.email
        profileScreen.phoneNumberTextField.text = contact.phoneNumber
        profileScreen.addressTextField.text = contact.address
        profileScreen.cityStateTextField.text = contact.cityState

        if let zipCode = contact.zipCode {
            profileScreen.zipCodeTextField.text = String(zipCode)
        }
        
        if let phoneType = contact.phoneType,
           let index = Utilities.types.firstIndex(of: phoneType) {
            profileScreen.phoneTypePicker.selectRow(index, inComponent: 0, animated: false)
            selectedPhoneType = phoneType
        }
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
}


//MARK: adopting the required protocols...
extension ProfileScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Utilities.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return Utilities.types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedPhoneType = Utilities.types[row]
        }
}
