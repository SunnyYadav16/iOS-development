//
//  ProfileViewController.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    let profileScreen = ProfileScreenView()
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile Page"
        
        getUserProfile()
    }
    
    func displayUserProfile(user: UserProfile) {
        profileScreen.nameLabel.text = "Name: \(user.name)"
        profileScreen.emailLabel.text = "Email: \(user.email)"
    }
    
    func navigateToLogin() {
        UserDefaults.standard.removeObject(forKey: "x-access-token")
        let loginVC = ViewController()
        navigationController?.setViewControllers([loginVC], animated: true)
    }
    
}

extension ProfileViewController: AlertProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
