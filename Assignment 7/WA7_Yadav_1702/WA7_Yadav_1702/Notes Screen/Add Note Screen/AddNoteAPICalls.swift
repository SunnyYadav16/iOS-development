//
//  AddNoteAPICalls.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import Foundation
import UIKit
import Alamofire

extension AddNoteViewController: NotesAddAPIProtocol {
    
    func addNote(title: String, text: String) {
        guard let token = UserDefaults.standard.string(forKey: "x-access-token") else {
            showAlert(title: "Authentication Error", message: "Please login again.")
            navigateToLogin()
            return
        }
        
        if let url = URL(string: APIConfigs.noteURL+"post") {
            
            AF.request(url, method: .post, parameters: ["text": text], headers: ["x-access-token": token])
            .responseData { response in
                
                let status = response.response?.statusCode
                
                switch response.result {
                case .success(let data):
                    if let uwStatusCode = status {
                        switch uwStatusCode {
                        case 200...299:
                            self.addNoteScreen.titleTextField.text = ""
                            self.addNoteScreen.textView.text = ""
                            
                            self.showSuccessAndGoBack()
                            break
                            
                        case 401:
                            self.showAlert(title: "Session Expired", message: "Please login again.")
                            self.navigateToLogin()
                            break
                            
                        case 400...499:
                            print("Client error: \(String(data: data, encoding: .utf8) ?? "")")
                            self.showAlert(title: "Error", message: "Failed to save note. Please try again.")
                            break
                            
                        default:
                            print("Server error: \(String(data: data, encoding: .utf8) ?? "")")
                            self.showAlert(title: "Server Error", message: "Unable to save note. Please try again later.")
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
