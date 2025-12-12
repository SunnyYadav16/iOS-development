//
//  AddNoteViewController.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import UIKit
import Alamofire

class AddNoteViewController: UIViewController {
    
    let addNoteScreen = AddNoteView()
    
    override func loadView() {
        view = addNoteScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Note"
        
        addNoteScreen.saveButton.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
        
        hideKeyboardOnTapOutside()
    }
    
    @objc func onSaveButtonTapped() {
        // Validate Title
        guard let title = addNoteScreen.titleTextField.text,
              !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter a note title.")
            return
        }
        
        // Validate Text
        guard let text = addNoteScreen.textView.text,
              !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter note content.")
            return
        }
        
        addNote(title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                text: text.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    func showSuccessAndGoBack() {
        let alert = UIAlertController(title: "Success", message: "Note saved successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
    
    func navigateToLogin() {
        UserDefaults.standard.removeObject(forKey: "x-access-token")
        let loginVC = ViewController()
        navigationController?.setViewControllers([loginVC], animated: true)
    }
}

extension AddNoteViewController: KeyboardProtocol {
    func hideKeyboardOnTapOutside(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}

extension AddNoteViewController: AlertProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
