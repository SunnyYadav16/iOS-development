//
//  EditContactView.swift
//  Working with APIs
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit

class EditContactView: UIView {
    
    var editContentWrapper:UIScrollView!
    var nameLabel: UILabel!
    var nameTextField: UITextField!
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var phoneLabel: UILabel!
    var phoneTextField: UITextField!
    var saveButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setUpeditContentWrapper()
        setUpNameLabel()
        setUpNameTextField()
        setUpEmailLabel()
        setUpEmailTextField()
        setUpPhoneLabel()
        setUpPhoneTextField()
        setupSaveButton()
        initConstraints()
    }
    
    func setUpeditContentWrapper(){
        editContentWrapper = UIScrollView()
        editContentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editContentWrapper)
    }
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = "Name:"
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        editContentWrapper.addSubview(nameLabel)
    }
    
    func setUpNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        editContentWrapper.addSubview(nameTextField)
    }
    
    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "Email:"
        emailLabel.font = .systemFont(ofSize: 16, weight: .medium)
        emailLabel.textColor = .label
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        editContentWrapper.addSubview(emailLabel)
    }
    
    func setUpEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        editContentWrapper.addSubview(emailTextField)
    }
    
    func setUpPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.text = "Phone:"
        phoneLabel.font = .systemFont(ofSize: 16, weight: .medium)
        phoneLabel.textColor = .label
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        editContentWrapper.addSubview(phoneLabel)
    }
    
    func setUpPhoneTextField() {
        phoneTextField = UITextField()
        phoneTextField.placeholder = "Phone"
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.keyboardType = .numberPad
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        editContentWrapper.addSubview(phoneTextField)
    }
    
    func setupSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        editContentWrapper.addSubview(saveButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            editContentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            editContentWrapper.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            editContentWrapper.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            editContentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: editContentWrapper.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: editContentWrapper.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: editContentWrapper.leadingAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: editContentWrapper.leadingAnchor, constant: 20),
            emailLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: editContentWrapper.leadingAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            phoneLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: editContentWrapper.leadingAnchor, constant: 20),
            phoneLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: editContentWrapper.leadingAnchor, constant: 20),
            phoneTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            saveButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 40),
            saveButton.centerXAnchor.constraint(equalTo: editContentWrapper.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.bottomAnchor.constraint(equalTo: editContentWrapper.bottomAnchor, constant: -40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
