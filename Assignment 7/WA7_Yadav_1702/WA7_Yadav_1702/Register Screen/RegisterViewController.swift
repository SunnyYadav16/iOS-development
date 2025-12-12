//
//  RegisterViewController.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    let registerScreen = RegisterScreenView()
    
    override func loadView() {
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register Page"
        
        navigationItem.hidesBackButton = true
        
        registerScreen.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
        registerScreen.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        
        hideKeyboardOnTapOutside()
    }
   
    @objc func onRegisterButtonTapped() {
        // Validate Name
        guard let name = registerScreen.nameTextField.text,
              !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your name.")
            return
        }
        
        // Validate Email
        guard let email = registerScreen.emailTextField.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your email.")
            return
        }
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidEmail(trimmedEmail) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        
        // Validate Password
        guard let password = registerScreen.passwordTextField.text,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your password.")
            return
        }
        
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedPassword.count < 6 {
            showAlert(title: "Weak Password", message: "Password must be at least 6 characters long.")
            return
        }
        
        registerUser(name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                    email: trimmedEmail,
                    password: trimmedPassword)
    }
    
    @objc func onLoginButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func registerUser(name: String, email: String, password: String) {
        if let url = URL(string: APIConfigs.authenticationURL+"register") {
                
            AF.request(url, method: .post, parameters: [
                "name": name,
                "email": email,
                "password": password
            ], encoding: URLEncoding.default)
            .responseData { response in
                
            let status = response.response?.statusCode
                
                switch response.result {
                case .success(let data):
                    if let uwStatusCode = status {
                        switch uwStatusCode {
                        case 200...299:
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                                   let token = json["token"] as? String {
                                    
                                    UserDefaults.standard.set(token, forKey: "x-access-token")
                                    
                                    self.registerScreen.nameTextField.text = ""
                                    self.registerScreen.emailTextField.text = ""
                                    self.registerScreen.passwordTextField.text = ""
                                    
                                    self.navigateToNotesPage()
                                } else {
                                    self.showAlert(title: "Error", message: "Invalid response from server.")
                                }
                            } catch {
                                print("JSON parsing error: \(error)")
                                self.showAlert(title: "Error", message: "Failed to process server response.")
                            }
                            break
                            
                        case 400...499:
                            if let errorMessage = String(data: data, encoding: .utf8) {
                                print("Error: \(errorMessage)")
                            }
                            self.showAlert(title: "Registration Failed", message: "This name/email is already registered. Please use different credentials.")
                            break

                        default:
                            if let errorMessage = String(data: data, encoding: .utf8) {
                                print("Server error (\(uwStatusCode)): \(errorMessage)")
                                
                                if errorMessage.contains("email is unique") || errorMessage.contains("already registered") {
                                    self.showAlert(title: "Registration Failed", message: "This name/email is already registered. Please use different credentials.")
                                }
                            } else {
                                self.showAlert(title: "Server Error", message: "Something went wrong. Please try again later.")
                            }
                            break
                        }
                    }
                    break
                    
                case .failure(let error):
                    print("Network error: \(error)")
                    self.showAlert(title: "Network Error", message: "Unable to connect to server. Please check your connection.")
                    break
                }
            }
        } else {
            showAlert(title: "Error", message: "Invalid URL configuration.")
        }
    }
    
    func navigateToNotesPage() {
        let notesVC = NotesViewController()
        
        if let navigationController = self.navigationController {
            navigationController.setViewControllers([notesVC], animated: true)
        } else {
            let navController = UINavigationController(rootViewController: notesVC)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
        }
    }
}

extension RegisterViewController: KeyboardProtocol {
    func hideKeyboardOnTapOutside(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
        
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}

extension RegisterViewController: AlertProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
