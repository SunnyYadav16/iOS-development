//
//  ViewController.swift
//  WA3_Yadav_1702
//
//  Created by Sunny Yadav on 9/29/25.
//

import UIKit

class ViewController: UIViewController {

    let mainView = MainView()
    
    let phoneType: [String] = ["Cell", "Work", "Home"]
    var selectedPhoneType = "Cell"
    
    public struct UserDetails {
        var name: String?
        var email: String?
        var phoneType: String?
        var phoneNumber: String?
        var address: String?
        var cityState: String?
        var zipCode: Int?
        
        init(name: String? = nil, email: String? = nil, phoneType: String? = nil, phoneNumber: String? = nil, address: String? = nil, cityState: String? = nil, zipCode: Int? = nil) {
            self.name = name
            self.email = email
            self.phoneType = phoneType
            self.phoneNumber = phoneNumber
            self.address = address
            self.cityState = cityState
            self.zipCode = zipCode
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Profile"
        
        mainView.phoneTypePicker.delegate = self
        mainView.phoneTypePicker.dataSource = self
        
        mainView.showProfileButton.addTarget(self, action: #selector(onShowButtonClicked), for: .touchUpInside)
    }
    
    @objc func onShowButtonClicked() {
        guard let name = mainView.nameTextField.text,
              !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message:"Please enter your name.")
            return
        }
        
        guard let email = mainView.emailTextField.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your email")
            return
        }
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidEmail(trimmedEmail) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address")
            return
        }
    
        guard let phoneNumber = mainView.phoneNumberTexTField.text,
              !phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your phone number")
            return
        }
        
        let trimmedPhone = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidPhoneNumber(trimmedPhone) {
            showAlert(title: "Invalid Phone", message: "Please enter a valid 10-digit phone number")
            return
        }
        
        var zipInt: Int? = nil
        let eligibleRange = 00001...99950
        if let zipText = mainView.zipCodeTextField.text, !zipText.isEmpty {
            guard let zip = Int(zipText), zipText.count == 5, eligibleRange.contains(zip) else {
                showAlert(title: "Invalid ZIP", message: "Please enter a valid 5-digit ZIP code")
                return
            }
            zipInt = zip
        }
        
        if let cityState = mainView.cityStateTextField.text, !cityState.isEmpty {
            let trimmedCityState = cityState.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let parts = trimmedCityState.split(separator: ", ").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            
            if parts.count != 2 || parts[0].isEmpty || parts[1].isEmpty {
                showAlert(title: "Invalid Format", message: "Please enter both city and state (e.g., Boston, MA)")
                return
            }
        }
        
        let userData = UserDetails(
            name: name,
            email: email.lowercased(),
            phoneType: selectedPhoneType,
            phoneNumber: phoneNumber,
            address: mainView.addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            cityState: mainView.cityStateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            zipCode: zipInt
        )
        
        let displayViewController = DisplayViewController()
        displayViewController.userData = userData
        navigationController?.pushViewController(displayViewController, animated: true)
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


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return phoneType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPhoneType = phoneType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return phoneType[row]
    }
}

