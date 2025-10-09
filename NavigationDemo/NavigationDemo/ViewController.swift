//
//  ViewController.swift
//  NavigationDemo
//
//  Created by Sunny Yadav on 9/22/25.
//

import UIKit

class ViewController: UIViewController {
    
    var textFieldMessage: UITextField!
    var buttonSend: UIButton!
    var labelMood: UILabel!
    var imageMood: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //MARK: initializing the UI elements...
        setupTextFieldMessage()
        setupButtonSend()
        setupLabelMood()
        setupImageMood()
        
        //MARK: initializing the constraints...
        initConstraints()
        
        //MARK: on buttonSend tap...
        buttonSend.addTarget(self, action: #selector(onButtonSendTapped),
                             for: .touchUpInside)
    }
    
    // textFieldMessage...
    func setupTextFieldMessage(){
        textFieldMessage = UITextField()
        textFieldMessage.placeholder = "Put your message here"
        textFieldMessage.borderStyle = .roundedRect
        textFieldMessage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldMessage)
    }
    
    //buttonSend...
    func setupButtonSend(){
        buttonSend = UIButton(type: .system)
        buttonSend.setTitle("Send", for: .normal)
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonSend)
    }
    
    //labelMood...
    func setupLabelMood(){
        labelMood = UILabel()
        labelMood.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelMood)
    }
    
    //imageMood...
    func setupImageMood(){
        imageMood = UIImageView()
        imageMood.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageMood)
    }
    
    // MARK: On button tapped delegate...
    @objc func onButtonSendTapped(){
        //initializing a new screen with ShowViewController...
        let showViewController = ShowViewController()
        
        //set the message to ShowViewController's messageFromFirstScreen variable...
        if let unwrappedMessage = textFieldMessage.text{
            if !unwrappedMessage.isEmpty{ // checking if the user has put any message...
                showViewController.messageFromFirstScreen = unwrappedMessage
            }
            showViewController.delegate = self
        }
        
        //push the screen to Stack...
        navigationController?.pushViewController(showViewController, animated: true)
    }
    
    //MARK: delegated method from ShowViewController...
    func delegateButtonSendMood(mood: String){
        print("The user is \(mood)")
        imageMood.image = UIImage(named: mood.lowercased())
    }
        
    
    //MARK: initializing constraints...
    func initConstraints(){
        
        NSLayoutConstraint.activate([
            // textFieldMessage constraints...
            textFieldMessage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFieldMessage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            // buttonSend constraints...
            buttonSend.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonSend.topAnchor.constraint(equalTo: textFieldMessage.bottomAnchor, constant: 16),
            
            // labelMood constraints...
            labelMood.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            labelMood.topAnchor.constraint(equalTo: buttonSend.bottomAnchor, constant: 16),// labelMood constraints...
            
            // imageMood constraints...
            imageMood.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageMood.topAnchor.constraint(equalTo: labelMood.bottomAnchor, constant: 16),
        ])
        
    }


}

