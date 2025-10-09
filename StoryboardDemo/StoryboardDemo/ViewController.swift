//
//  ViewController.swift
//  StoryboardDemo
//
//  Created by Sunny Yadav on 9/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textFIeldUser: UITextField!
    @IBOutlet weak var buttonClickMe: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonClickMe.addTarget(self, action: #selector(onButtonClickMeTapped), for: .touchUpInside)
    }
    
    @objc func onButtonClickMeTapped() {
        let text = textFIeldUser.text
        if let unwrappedText = text {
            if(unwrappedText.isEmpty){ //The user didn't put anything...
                showErrorAlert()
            } else{ //The user put some texts...
                showAlertText(text: unwrappedText)
            }
        }
    }
    
    func showErrorAlert(){
        let alert = UIAlertController(
            title: "Error!", message: "Text Field must not be empty!",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
    //MARK: text alert...
    func showAlertText(text:String){
        let alert = UIAlertController(
            title: "You said:",
            message: "\(text)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
}
