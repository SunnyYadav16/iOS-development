//
//  AddProfileScreen.swift
//  WA5_Yadav_1702
//
//  Created by Sunny Yadav on 10/9/25.
//

import UIKit

class ProfileScreenView: UIView {
    
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var phoneNumberTextField: UITextField!
    var addressTextField: UITextField!
    var cityStateTextField: UITextField!
    var zipCodeTextField: UITextField!
    var phoneSelectType: UIButton!
    var profileImageButton: UIButton!
    var saveButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUpNameTextField()
        setUpEmailTextField()
        setUpPhoneNumberTextField()
        setUpAddressTextField()
        setUpCityStateTextField()
        setUpZipCodeTextField()
        setUpPhoneTypeField()
        setupProfileImageButton()
        setUpSaveButton()
        
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
    
    func setUpPhoneTypeField() {
        phoneSelectType = UIButton(type: .system)
        phoneSelectType.showsMenuAsPrimaryAction = true
        phoneSelectType.contentHorizontalAlignment = .right
        phoneSelectType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneSelectType)
    }
    
    func setupProfileImageButton(){
        profileImageButton = UIButton(type: .custom)
        profileImageButton.setTitle("", for: .normal)
        profileImageButton.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        profileImageButton.showsMenuAsPrimaryAction = true
        profileImageButton.contentHorizontalAlignment = .fill
        profileImageButton.contentVerticalAlignment = .fill
        profileImageButton.imageView?.contentMode = .scaleAspectFill
        profileImageButton.clipsToBounds = true
        profileImageButton.layer.cornerRadius = 40
        profileImageButton.layer.borderColor = UIColor.systemGray4.cgColor
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImageButton)
    }
    
    func setUpSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(saveButton)
    }
 
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // Profile Image Button
            profileImageButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            profileImageButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageButton.widthAnchor.constraint(equalToConstant: 80),
            profileImageButton.heightAnchor.constraint(equalToConstant: 80),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    
            // Phone Number TextField
            phoneNumberTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: phoneSelectType.leadingAnchor, constant: -10),
            
            // Phone Type Button
            phoneSelectType.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            phoneSelectType.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            phoneSelectType.widthAnchor.constraint(equalToConstant: 80),
            phoneSelectType.centerYAnchor.constraint(equalTo: phoneNumberTextField.centerYAnchor),
        
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
            
            // Save Button
            saveButton.topAnchor.constraint(equalTo: zipCodeTextField.bottomAnchor, constant: 40),
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
}
