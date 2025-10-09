//
//  AddProfileScreen.swift
//  WA4_Yadav_1702
//
//  Created by Sunny Yadav on 10/6/25.
//

import UIKit

class ProfileScreenView: UIView {
    
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var addPhoneLabel: UILabel!
    var phoneTypePicker: UIPickerView!
    var phoneNumberTextField: UITextField!
    var addressTextField: UITextField!
    var cityStateTextField: UITextField!
    var zipCodeTextField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUpNameTextField()
        setUpEmailTextField()
        setUpPhoneNumberTextField()
        setUpAddressTextField()
        setUpCityStateTextField()
        setUpZipCodeTextField()
        setUpPhoneLabelField()
        setUpPhoneTypeField()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpNameTextField(){
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameTextField)
    }
    
    func setUpEmailTextField(){
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailTextField)
    }
    
    func setUpPhoneNumberTextField(){
        phoneNumberTextField = UITextField()
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneNumberTextField)
    }
    
    func setUpAddressTextField(){
        addressTextField = UITextField()
        addressTextField.placeholder = "Address"
        addressTextField.borderStyle = .roundedRect
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressTextField)
    }
    
    func setUpCityStateTextField(){
        cityStateTextField = UITextField()
        cityStateTextField.placeholder = "City, State"
        cityStateTextField.borderStyle = .roundedRect
        cityStateTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityStateTextField)
    }
    
    func setUpZipCodeTextField(){
        zipCodeTextField = UITextField()
        zipCodeTextField.placeholder = "ZIP"
        zipCodeTextField.keyboardType = .numberPad
        zipCodeTextField.borderStyle = .roundedRect
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipCodeTextField)
    }
    
    func setUpPhoneLabelField() {
        addPhoneLabel = UILabel()
        addPhoneLabel.text = "Add Phone"
        addPhoneLabel.font = UIFont.boldSystemFont(ofSize: 18)
        addPhoneLabel.textAlignment = .center
        addPhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addPhoneLabel)
    }
    
    func setUpPhoneTypeField() {
        phoneTypePicker = UIPickerView()
        phoneTypePicker.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneTypePicker)
    }
 
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // Add Phone Label
            addPhoneLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            addPhoneLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addPhoneLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // Phone Type Picker
            phoneTypePicker.topAnchor.constraint(equalTo: addPhoneLabel.bottomAnchor, constant: 8),
            phoneTypePicker.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            phoneTypePicker.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            phoneTypePicker.heightAnchor.constraint(equalToConstant: 100),
            
            // Phone Number TextField
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneTypePicker.bottomAnchor, constant: 16),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // Address TextField
            addressTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 16),
            addressTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // City State TextField
            cityStateTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 16),
            cityStateTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cityStateTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // ZIP Code TextField
            zipCodeTextField.topAnchor.constraint(equalTo: cityStateTextField.bottomAnchor, constant: 16),
            zipCodeTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            zipCodeTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
}
