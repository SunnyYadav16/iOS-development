//
//  ProfileAPICalls.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import Foundation
import UIKit
import Alamofire

extension ProfileViewController: ProfileAPIProtocol {
    
    func getUserProfile() {
        guard let token = UserDefaults.standard.string(forKey: "x-access-token") else {
            showAlert(title: "Authentication Error", message: "Please login again.")
            navigateToLogin()
            return
        }
        
        if let url = URL(string: APIConfigs.authenticationURL+"me") {
            
            AF.request(url, method: .get, headers: ["x-access-token": token])
                .responseData { response in
                    
                    let status = response.response?.statusCode
                    
                    switch response.result {
                    case .success(let data):
                        if let uwStatusCode = status {
                            switch uwStatusCode {
                            case 200...299:
                                let decoder = JSONDecoder()
                                do {
                                    let userData = try decoder.decode(UserProfile.self, from: data)
                                    self.displayUserProfile(user: userData)
                                } catch {
                                    print("JSON decoding error: \(error)")
                                    self.showAlert(title: "Error", message: "Failed to parse user data.")
                                }
                                break
                                
                            case 401:
                                self.showAlert(title: "Session Expired", message: "Please login again.")
                                self.navigateToLogin()
                                break
                                
                            case 400...499:
                                print("Client error: \(String(data: data, encoding: .utf8) ?? "")")
                                self.showAlert(title: "Error", message: "Failed to load profile.")
                                break
                                
                            default:
                                print("Server error: \(String(data: data, encoding: .utf8) ?? "")")
                                self.showAlert(title: "Server Error", message: "Unable to load profile. Please try again.")
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
        }
    }
}
