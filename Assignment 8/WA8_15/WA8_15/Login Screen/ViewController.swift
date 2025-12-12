//
//  ViewController.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        loginView.buttonLogin.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        
        loginView.textFieldEmail.delegate = self
        loginView.textFieldPassword.delegate = self
        
        hideKeyboardOnTapOutside()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func onLoginTapped() {
        guard let email = loginView.textFieldEmail.text, !email.isEmpty else {
            showAlert(title: "Error", message: "Please enter your email.")
            return
        }
        
        guard let password = loginView.textFieldPassword.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Please enter your password.")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                let errorMessage = self.getErrorMessage(from: error)
                showAlert(title: "Login Failed", message: errorMessage)
            } else {
                self.navigateToMainScreen()
            }
        }
    }
    
    @objc func onRegisterTapped() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func navigateToMainScreen() {
        loginView.textFieldEmail.text = ""
        loginView.textFieldPassword.text = ""
        
        let chatListVC = ChatListViewController()
        let navController = UINavigationController(rootViewController: chatListVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func getErrorMessage(from error: Error) -> String {
        let nsError = error as NSError
        
        switch nsError.code {
        case AuthErrorCode.invalidEmail.rawValue:
            return "The email address is invalid."
        case AuthErrorCode.userDisabled.rawValue:
            return "This account has been disabled."
        case AuthErrorCode.wrongPassword.rawValue:
            return "The password is incorrect."
        case AuthErrorCode.userNotFound.rawValue:
            return "No account found with this email address."
        case AuthErrorCode.networkError.rawValue:
            return "Network error. Please check your connection."
        case AuthErrorCode.invalidCredential.rawValue:
            return "Invalid email or password."
        default:
            return error.localizedDescription
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.textFieldEmail {
            loginView.textFieldPassword.becomeFirstResponder()
        } else if textField == loginView.textFieldPassword {
            textField.resignFirstResponder()
            onLoginTapped()
        }
        return true
    }
}


extension ViewController: KeyboardProtocol {
    func hideKeyboardOnTapOutside(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}

extension ViewController: AlertProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
