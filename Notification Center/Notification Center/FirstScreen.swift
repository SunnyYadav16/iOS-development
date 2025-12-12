//
//  FirstScreen.swift
//  Notification Center
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit

class FirstScreenView: UIView {
    var buttonFetch:UIButton!
    var labelReceivedText:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupButtonFetch()
        setupLabelReceivedText()
        
        initConstraints()
    }
    
    //MARK: initializing UI elements...
    func setupButtonFetch(){
        buttonFetch = UIButton(type: .system)
        buttonFetch.setTitle("Fetch Text from Second Screen", for: .normal)
        buttonFetch.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonFetch)
    }
    
    func setupLabelReceivedText(){
        labelReceivedText = UILabel()
        labelReceivedText.text = "Will receive text from Screen 2"
        labelReceivedText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelReceivedText)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            buttonFetch.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            buttonFetch.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelReceivedText.topAnchor.constraint(equalTo: buttonFetch.bottomAnchor, constant: 32),
            labelReceivedText.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    //MARK: unused methods...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
