//
//  MainView.swift
//  WA3_Yadav_1702
//
//  Created by Sunny Yadav on 9/29/25.
//

import UIKit

class MainView: UIView {
    
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var addPhoneLabel: UILabel!
    var selectTypeLabel: UILabel!
    var phoneTypePicker: UIPickerView!
    var phoneNumberTexTField: UITextField!
    var addressTextField: UITextField!
    var cityStateTextField: UITextField!
    var zipCodeTextField: UITextField!
    
    var showProfileButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        setUpNameTextField()
        setUpEmailTextField()
        setUpAddPhoneLabel()
        setUpSelectTypeLabel()
        setUpPhoneTypePicker()
        setUpPhoneNumberTextField()
        setUpAddressTextField()
        setUpCityStateTextField()
        setUpZipCodeTextField()
        setUpShowProfileButton()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpAddPhoneLabel() {
        addPhoneLabel = UILabel()
        addPhoneLabel.text = "Add Phone"
        addPhoneLabel.font = addPhoneLabel.font.withSize(22)
        addPhoneLabel.textAlignment = .center
        addPhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addPhoneLabel)
    }

    func setUpSelectTypeLabel() {
        selectTypeLabel = UILabel()
        selectTypeLabel.text = "Select Type:"
        selectTypeLabel.font = selectTypeLabel.font.withSize(18)
        selectTypeLabel.textAlignment = .center
        selectTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectTypeLabel)
    }
    
    func setUpPhoneTypePicker() {
        phoneTypePicker = UIPickerView()
        phoneTypePicker.isUserInteractionEnabled = true
        phoneTypePicker.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneTypePicker)
    }
    
    func setUpNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameTextField)
    }
    
    func setUpEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailTextField)
    }
    
    func setUpPhoneNumberTextField() {
        phoneNumberTexTField = UITextField()
        phoneNumberTexTField.placeholder = "Phone Number"
        phoneNumberTexTField.keyboardType = .phonePad
        phoneNumberTexTField.borderStyle = .roundedRect
        phoneNumberTexTField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneNumberTexTField)
    }
    
    func setUpAddressTextField() {
        addressTextField = UITextField()
        addressTextField.placeholder = "Address"
        addressTextField.borderStyle = .roundedRect
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressTextField)
    }
    
    func setUpCityStateTextField() {
        cityStateTextField = UITextField()
        cityStateTextField.placeholder = "City, State"
        cityStateTextField.borderStyle = .roundedRect
        cityStateTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityStateTextField)
    }
    
    func setUpZipCodeTextField() {
        zipCodeTextField = UITextField()
        zipCodeTextField.placeholder = "ZIP"
        zipCodeTextField.keyboardType = .numberPad
        zipCodeTextField.borderStyle = .roundedRect
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipCodeTextField)
    }
    
    func setUpShowProfileButton() {
        showProfileButton = UIButton(type: .system)
        showProfileButton.setTitle( "Show Profile", for: .normal)
        showProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(showProfileButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            nameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Add Phone Label
            addPhoneLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            addPhoneLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            addPhoneLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Select Type Label
            selectTypeLabel.topAnchor.constraint(equalTo: addPhoneLabel.bottomAnchor, constant: 8),
            selectTypeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            selectTypeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),

            phoneTypePicker.topAnchor.constraint(equalTo: selectTypeLabel.bottomAnchor, constant: 4),
            phoneTypePicker.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            phoneTypePicker.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            phoneTypePicker.heightAnchor.constraint(equalToConstant: 100),
            
            // Phone Number TextField
            phoneNumberTexTField.topAnchor.constraint(equalTo: phoneTypePicker.bottomAnchor, constant: 16),
            phoneNumberTexTField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            phoneNumberTexTField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Address TextField
            addressTextField.topAnchor.constraint(equalTo: phoneNumberTexTField.bottomAnchor, constant: 16),
            addressTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            addressTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // City, State TextField
            cityStateTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 16),
            cityStateTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            cityStateTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // ZIP Code TextField
            zipCodeTextField.topAnchor.constraint(equalTo: cityStateTextField.bottomAnchor, constant: 16),
            zipCodeTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            zipCodeTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Show Profile Button
            showProfileButton.topAnchor.constraint(equalTo: zipCodeTextField.bottomAnchor, constant: 32),
            showProfileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
    }
}
