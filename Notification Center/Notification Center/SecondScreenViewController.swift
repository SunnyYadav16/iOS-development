//
//  SecondScreenViewController.swift
//  Notification Center
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit

class SecondScreenViewController: UIViewController {
    let secondScreen = SecondScreen()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = secondScreen
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second Screen"
        
        secondScreen.buttonSendBack
            .addTarget(self, action: #selector(onButtonSendBackTapped), for: .touchUpInside)
        
    }
    
    @objc func onButtonSendBackTapped(){
        if let text = secondScreen.textFieldSendBack.text{
            //MARK: posting text to NotificationCenter...
            notificationCenter.post(
                name: .textFromScondScreen,
                object: text)
            navigationController?.popViewController(animated: true)
        }else{
            //Alert invalid input...
        }
        
    }
}
