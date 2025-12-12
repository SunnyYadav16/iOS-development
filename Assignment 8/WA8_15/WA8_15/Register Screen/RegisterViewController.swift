//
//  RegisterViewController.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    var pickedImage: UIImage?
    let storage = Storage.storage()
    let database = Firestore.firestore()
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        title = "Register"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        registerView.buttonTakePhoto.menu = getMenuImagePicker()
        
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        registerView.loginButton.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        
        registerView.textFieldName.delegate = self
        registerView.textFieldEmail.delegate = self
        registerView.textFieldPassword.delegate = self
        registerView.textFieldRepeatPassword.delegate = self
        
        hideKeyboardOnTapOutside()
    }
    
    @objc func onLoginTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onRegisterTapped() {
        guard let name = registerView.textFieldName.text, !name.isEmpty else {
            showAlert(title: "Error", message: "Please enter your name.")
            return
        }
        
        guard let email = registerView.textFieldEmail.text, !email.isEmpty else {
            showAlert(title: "Error", message: "Please enter your email.")
            return
        }
        
        guard let password = registerView.textFieldPassword.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Please enter a password.")
            return
        }
        
        guard let repeatPassword = registerView.textFieldRepeatPassword.text, !repeatPassword.isEmpty else {
            showAlert(title: "Error", message: "Please repeat your password.")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        
        if password != repeatPassword {
            showAlert(title: "Password Mismatch", message: "Passwords do not match. Please try again.")
            return
        }
        
        if password.count < 6 {
            showAlert(title: "Weak Password", message: "Password must be at least 6 characters long.")
            return
        }
        
        uploadProfilePhotoToStorage()
    }
    
    func uploadProfilePhotoToStorage() {
        var profilePhotoURL: URL?
        
        if let image = pickedImage {
            if let jpegData = image.jpegData(compressionQuality: 0.5) {
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("profileImages")
                let imageRef = imagesRepo.child("\(UUID().uuidString).jpg")
                
                imageRef.putData(jpegData) { [weak self] metadata, error in
                    guard let self = self else { return }
                    
                    if error == nil {
                        imageRef.downloadURL { url, error in
                            if error == nil {
                                profilePhotoURL = url
                                self.registerUser(photoURL: profilePhotoURL)
                            } else {
                                self.registerUser(photoURL: nil)
                            }
                        }
                    } else {
                        self.registerUser(photoURL: nil)
                    }
                }
            } else {
                registerUser(photoURL: nil)
            }
        } else {
            registerUser(photoURL: nil)
        }
    }
    
    func registerUser(photoURL: URL?) {
        guard let name = registerView.textFieldName.text,
              let email = registerView.textFieldEmail.text,
              let password = registerView.textFieldPassword.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                let errorMessage = self.getErrorMessage(from: error)
                showAlert(title: "Registration Failed", message: errorMessage)
                
            } else if let user = result?.user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.photoURL = photoURL
                
                changeRequest.commitChanges { [weak self] error in
                    guard let self = self else { return }
                    
                    if error == nil {
                        self.saveUserToFirestore(user: user, name: name, photoURL: photoURL)
                    } else {
                        showAlert(title: "Error", message: "Failed to update profile.")
                    }
                }
            }
        }
    }
    
    func saveUserToFirestore(user: User, name: String, photoURL: URL?) {
        let userData: [String: Any] = [
            "name": name,
            "email": user.email ?? "",
            "photoURL": photoURL?.absoluteString ?? "",
            "createdAt": FieldValue.serverTimestamp()
        ]
        
        database.collection("users").document(user.email ?? "").setData(userData) { [weak self] error in
            guard let self = self else { return }
            
            if error == nil {
                self.showSuccessAndNavigate()
            } else {
                showAlert(title: "Error", message: "Failed to save user data.")
            }
        }
    }
    
    func showSuccessAndNavigate() {
        let alert = UIAlertController(
            title: "Success!",
            message: "Your account has been created successfully.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigateToMainScreen()
        })
        
        present(alert, animated: true)
    }
    
    func navigateToMainScreen() {
        let chatListVC = ChatListViewController()
        let navController = UINavigationController(rootViewController: chatListVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func getMenuImagePicker() -> UIMenu {
        let menuItems = [
            UIAction(title: "Camera", handler: { _ in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery", handler: { _ in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera() {
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickPhotoFromGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        photoPicker.delegate = self
        present(photoPicker, animated: true)
    }
        
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func getErrorMessage(from error: Error) -> String {
        let nsError = error as NSError
        
        switch nsError.code {
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return "This email is already registered."
        case AuthErrorCode.invalidEmail.rawValue:
            return "The email address is invalid."
        case AuthErrorCode.weakPassword.rawValue:
            return "The password is too weak. Please use at least 6 characters."
        case AuthErrorCode.networkError.rawValue:
            return "Network error. Please check your connection."
        default:
            return error.localizedDescription
        }
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == registerView.textFieldName {
            registerView.textFieldEmail.becomeFirstResponder()
        } else if textField == registerView.textFieldEmail {
            registerView.textFieldPassword.becomeFirstResponder()
        } else if textField == registerView.textFieldPassword {
            registerView.textFieldRepeatPassword.becomeFirstResponder()
        } else if textField == registerView.textFieldRepeatPassword {
            textField.resignFirstResponder()
            onRegisterTapped()
        }
        return true
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
