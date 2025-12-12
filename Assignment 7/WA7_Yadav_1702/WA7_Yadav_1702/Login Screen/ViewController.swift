//
//  ViewController.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let loginScreen = LoginScreenView()
    
    override func loadView() {
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login Page"
        
        navigationItem.hidesBackButton = true
    
        loginScreen.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        loginScreen.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
        
        hideKeyboardOnTapOutside()
    }
    
    @objc func onLoginButtonTapped() {
        // Validate Email
        guard let email = loginScreen.emailTextField.text,
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
        guard let password = loginScreen.passwordTextField.text,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your password.")
            return
        }
        
        loginUser(email: trimmedEmail, password: password)
    }
    
    @objc func onRegisterButtonTapped() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func loginUser(email: String, password: String) {
        if let url = URL(string: APIConfigs.authenticationURL+"login") {

            AF.request(url, method: .post, parameters: [
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
                                    
                                    self.loginScreen.emailTextField.text = ""
                                    self.loginScreen.passwordTextField.text = ""
                                    
                                    let notesVC = NotesViewController()
                                    self.navigationController?.setViewControllers([notesVC], animated: true)
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
                            self.showAlert(title: "Login Failed", message: "Invalid email or password. Please try again.")
                            break
                            
                        default:
                            print("Server error with status code: \(uwStatusCode)")
                            self.showAlert(title: "Server Error", message: "Something went wrong. Please try again later.")
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
