//
//  RegisterView.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit

class RegisterView: UIView {
    var labelTitle: UILabel!
    var buttonTakePhoto: UIButton!
    var labelPhoto: UILabel!
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var textFieldRepeatPassword: UITextField!
    var buttonRegister: UIButton!
    var loginLabel: UILabel!
    var loginButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupLabelTitle()
        setupButtonTakePhoto()
        setupLabelPhoto()
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupTextFieldRepeatPassword()
        setupButtonRegister()
        setupLoginLabel()
        setupLoginButton()
        
        initConstraints()
    }
    
    func setupLabelTitle() {
        labelTitle = UILabel()
        labelTitle.text = "Create Account"
        labelTitle.font = .systemFont(ofSize: 32, weight: .bold)
        labelTitle.textAlignment = .center
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
    }
    
    func setupButtonTakePhoto() {
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setImage(UIImage(systemName: "person.crop.circle.badge.plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.layer.cornerRadius = 60
        buttonTakePhoto.clipsToBounds = true
        buttonTakePhoto.layer.borderWidth = 2
        buttonTakePhoto.layer.borderColor = UIColor.systemGray4.cgColor
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }
    
    func setupLabelPhoto() {
        labelPhoto = UILabel()
        labelPhoto.text = "Add Profile Photo"
        labelPhoto.font = .systemFont(ofSize: 14, weight: .medium)
        labelPhoto.textColor = .secondaryLabel
        labelPhoto.textAlignment = .center
        labelPhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPhoto)
    }
    
    func setupTextFieldName() {
        textFieldName = UITextField()
        textFieldName.placeholder = "Full Name"
        textFieldName.keyboardType = .default
        textFieldName.autocapitalizationType = .words
        textFieldName.borderStyle = .roundedRect
        textFieldName.backgroundColor = .secondarySystemBackground
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setupTextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.autocorrectionType = .no
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.backgroundColor = .secondarySystemBackground
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password (min 6 characters)"
        textFieldPassword.textContentType = .newPassword
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.backgroundColor = .secondarySystemBackground
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.autocorrectionType = .no
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupTextFieldRepeatPassword() {
        textFieldRepeatPassword = UITextField()
        textFieldRepeatPassword.placeholder = "Repeat Password"
        textFieldRepeatPassword.textContentType = .newPassword
        textFieldRepeatPassword.isSecureTextEntry = true
        textFieldRepeatPassword.borderStyle = .roundedRect
        textFieldRepeatPassword.backgroundColor = .secondarySystemBackground
        textFieldRepeatPassword.autocapitalizationType = .none
        textFieldRepeatPassword.autocorrectionType = .no
        textFieldRepeatPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldRepeatPassword)
    }
    
    func setupButtonRegister() {
        buttonRegister = UIButton(type: .system)
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        buttonRegister.backgroundColor = .systemBlue
        buttonRegister.setTitleColor(.white, for: .normal)
        buttonRegister.layer.cornerRadius = 8
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonRegister)
    }
    
    func setupLoginLabel() {
        loginLabel = UILabel()
        loginLabel.text = "Already have an account?"
        loginLabel.font = .systemFont(ofSize: 16, weight: .medium)
        loginLabel.textColor = .secondaryLabel
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginLabel)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        loginButton.setTitle("Login", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            buttonTakePhoto.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 30),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 120),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 120),
            
            labelPhoto.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 10),
            labelPhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            textFieldName.topAnchor.constraint(equalTo: labelPhoto.bottomAnchor, constant: 30),
            textFieldName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldName.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 20),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 20),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldRepeatPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 20),
            textFieldRepeatPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldRepeatPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldRepeatPassword.heightAnchor.constraint(equalToConstant: 50),
            
            buttonRegister.topAnchor.constraint(equalTo: textFieldRepeatPassword.bottomAnchor, constant: 40),
            buttonRegister.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonRegister.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonRegister.heightAnchor.constraint(equalToConstant: 50),
            
            loginLabel.topAnchor.constraint(equalTo: buttonRegister.bottomAnchor, constant: 30),
            loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -20),
            
            loginButton.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor, constant: 5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
