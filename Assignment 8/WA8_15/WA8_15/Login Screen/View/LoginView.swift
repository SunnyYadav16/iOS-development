//
//  LoginView.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit

class LoginView: UIView {
    var labelTitle: UILabel!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var registerLabel: UILabel!
    var registerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupLabelTitle()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonLogin()
        setupRegisterLabel()
        setupRegisterButton()
        
        initConstraints()
    }
    
    func setupLabelTitle() {
        labelTitle = UILabel()
        labelTitle.text = "Welcome Back"
        labelTitle.font = .systemFont(ofSize: 32, weight: .bold)
        labelTitle.textAlignment = .center
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
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
        textFieldPassword.placeholder = "Password"
        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.backgroundColor = .secondarySystemBackground
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.autocorrectionType = .no
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        buttonLogin.backgroundColor = .systemBlue
        buttonLogin.setTitleColor(.white, for: .normal)
        buttonLogin.layer.cornerRadius = 8
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func setupRegisterLabel() {
        registerLabel = UILabel()
        registerLabel.text = "Don't have an account?"
        registerLabel.font = .systemFont(ofSize: 16, weight: .medium)
        registerLabel.textColor = .secondaryLabel
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerLabel)
    }
    
    func setupRegisterButton() {
        registerButton = UIButton(type: .system)
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        registerButton.setTitle("Register", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
            labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 60),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 20),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 40),
            buttonLogin.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonLogin.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),
            
            registerLabel.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 30),
            registerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30),
            
            registerButton.centerYAnchor.constraint(equalTo: registerLabel.centerYAnchor),
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor, constant: 5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
