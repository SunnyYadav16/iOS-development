//
//  SecondScreen.swift
//  Notification Center
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit

class SecondScreen: UIView {
    
    var labelInfo: UILabel!
    var textFieldSendBack: UITextField!
    var buttonSendBack: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupLabelInfo()
        setupTextFieldSendBack()
        setupButtonSendBack()
        
        initConstraints()
    }
    
    //MARK: setting up UI elements...
    func setupLabelInfo(){
        labelInfo = UILabel()
        labelInfo.text = "Type to send back:"
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelInfo)
    }
    func setupTextFieldSendBack(){
        textFieldSendBack = UITextField()
        textFieldSendBack.placeholder = "Put text to send back to screen 1"
        textFieldSendBack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldSendBack)
    }
    func setupButtonSendBack(){
        buttonSendBack = UIButton(type: .system)
        buttonSendBack.setTitle("Send Back", for: .normal)
        buttonSendBack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSendBack)
    }
    
    //MARK: initializing constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelInfo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelInfo.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldSendBack.topAnchor.constraint(equalTo: labelInfo.bottomAnchor, constant: 16),
            textFieldSendBack.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonSendBack.topAnchor.constraint(equalTo: textFieldSendBack.bottomAnchor, constant: 8),
            buttonSendBack.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
