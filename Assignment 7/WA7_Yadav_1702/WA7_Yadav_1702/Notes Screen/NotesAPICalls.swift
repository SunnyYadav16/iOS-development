//
//  NotesAPICalls.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import Foundation
import UIKit
import Alamofire

extension NotesViewController: NotesAPIProtocol {
    
    func getAllNotes() {
        guard let token = UserDefaults.standard.string(forKey: "x-access-token") else {
            showAlert(title: "Authentication Error", message: "Please login again.")
            navigateToLogin()
            return
        }
            
        if let url = URL(string: APIConfigs.noteURL+"getall") {
                
                AF.request(url, method: .get, headers: ["x-access-token": token])
                    .responseData { response in
                        let status = response.response?.statusCode
                        
                        switch response.result {
                        case .success(let data):
                            if let uwStatusCode = status {
                                switch uwStatusCode {
                                case 200...299:
                                    self.notes.removeAll()
                                    let decoder = JSONDecoder()
                                    do {
                                        let receivedData = try decoder.decode(NotesData.self, from: data)
                                        self.notes = receivedData.notes
                                        self.notesScreen.tableViewNotes.reloadData()
                                    } catch {
                                        print("JSON decoding error: \(error)")
                                        self.showAlert(title: "Error", message: "Failed to parse notes data.")
                                    }
                                    break
                                    
                                case 401:
                                    self.showAlert(title: "Session Expired", message: "Please login again.")
                                    self.navigateToLogin()
                                    break
                                    
                                case 400...499:
                                    print("Client error: \(String(data: data, encoding: .utf8) ?? "")")
                                    self.showAlert(title: "Error", message: "Failed to load notes.")
                                    break
                                    
                                default:
                                    print("Server error: \(String(data: data, encoding: .utf8) ?? "")")
                                    self.showAlert(title: "Server Error", message: "Unable to load notes. Please try again.")
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
    
    func deleteNote(noteId: String, at indexPath: IndexPath) {
            guard let token = UserDefaults.standard.string(forKey: "x-access-token") else {
                showAlert(title: "Authentication Error", message: "Please login again.")
                navigateToLogin()
                return
            }
            
            if let url = URL(string: APIConfigs.noteURL+"delete") {
                
                AF.request(url, method: .post, parameters: ["id": noteId], headers: ["x-access-token": token])
                    .responseData { response in
                        let status = response.response?.statusCode
                        
                        switch response.result {
                        case .success(let data):
                            if let uwStatusCode = status {
                                switch uwStatusCode {
                                case 200...299:
                                    self.notes.remove(at: indexPath.row)
                                    self.notesScreen.tableViewNotes.deleteRows(at: [indexPath], with: .fade)
                                    break
                                    
                                case 401:
                                    self.showAlert(title: "Session Expired", message: "Please login again.")
                                    self.navigateToLogin()
                                    break
                                    
                                case 400...499:
                                    print("Client error: \(String(data: data, encoding: .utf8) ?? "")")
                                    self.showAlert(title: "Error", message: "Failed to delete note.")
                                    break
                                    
                                default:
                                    print("Server error: \(String(data: data, encoding: .utf8) ?? "")")
                                    self.showAlert(title: "Server Error", message: "Unable to delete note. Please try again.")
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

    func performLogout() {
        guard let token = UserDefaults.standard.string(forKey: "x-access-token") else {
            navigateToLogin()
            return
        }
        
        if let url = URL(string: APIConfigs.authenticationURL + "logout") {
            
            AF.request(url, method: .post, headers: ["x-access-token": token])
                .responseData { response in
                    UserDefaults.standard.removeObject(forKey: "x-access-token")
                    
                    let loginVC = ViewController()
                    self.navigationController?.setViewControllers([loginVC], animated: true)
                }
        } else {
            UserDefaults.standard.removeObject(forKey: "x-access-token")
            let loginVC = ViewController()
            navigationController?.setViewControllers([loginVC], animated: true)
        }
    }
}
