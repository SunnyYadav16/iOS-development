//
//  ViewController.swift
//  Notification Center
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit

class ViewController: UIViewController {

    let firstScreen = FirstScreenView()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = firstScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First Screen"
        
        //MARK: buttonSend target...
        firstScreen.buttonFetch
            .addTarget(self, action: #selector(onButtonFetchTapped), for: .touchUpInside)
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(notificationReceivedForTextChanged(notification:)),
                    name: .textFromScondScreen,
                    object: nil)
        
    }
    
    @objc func onButtonFetchTapped(){
        let secondScreen = SecondScreenViewController()
        navigationController?.pushViewController(secondScreen, animated: true)
    }
    
    @objc func notificationReceivedForTextChanged(notification: Notification){
            firstScreen.labelReceivedText.text = (notification.object as! String)
        }
}

