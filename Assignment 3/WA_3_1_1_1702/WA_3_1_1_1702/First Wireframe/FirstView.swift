//
//  FirstView.swift
//  WA_3_1_1_1702
//
//  Created by Sunny Yadav on 9/25/25.
//

import UIKit

class FirstView: UIView {
    
    var firstLabel: UILabel!
    var firstTextField: UITextField!
    var firstButton: UIButton!
    var secondTextField: UITextField!
    var thirdTextField: UITextField!
    var secondButton: UIButton!
    var fourthTextField: UITextField!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        //MARK: initializing the UI elements and constraints...
        setUpFirstLabel()
        setUpFirstTextField()
        setUpFirstButton()
        setUpSecondTextField()
        setUpThirdTextField()
        setUpSecondButton()
        setUpFourthTextField()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpFirstLabel() {
        firstLabel = UILabel()
        firstLabel.text = "Label"
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstLabel)
    }
    
    func setUpFirstTextField() {
        firstTextField = UITextField()
        firstTextField.placeholder = "Aa"
        firstTextField.borderStyle = .roundedRect
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstTextField)
    }

    func setUpFirstButton() {
        firstButton = UIButton(type: .system)
        firstButton.setTitle("Button", for: .normal)
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstButton)
    }
    
    func setUpSecondTextField() {
        secondTextField = UITextField()
        secondTextField.placeholder = "Aa"
        secondTextField.borderStyle = .roundedRect
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(secondTextField)
    }
    
    func setUpThirdTextField() {
        thirdTextField = UITextField()
        thirdTextField.placeholder = "Aa"
        thirdTextField.borderStyle = .roundedRect
        thirdTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(thirdTextField)
    }
    
    func setUpSecondButton() {
        secondButton = UIButton(type: .system)
        secondButton.setTitle( "Button", for: .normal)
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(secondButton)
    }
    
    func setUpFourthTextField() {
        fourthTextField = UITextField()
        fourthTextField.placeholder = "Aa"
        fourthTextField.borderStyle = .roundedRect
        fourthTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fourthTextField)
    }
    
    func initConstraints() {
            NSLayoutConstraint.activate([
                // Row 1: First TextField and Label
                firstTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
                firstTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                firstTextField.trailingAnchor.constraint(equalTo: firstLabel.leadingAnchor, constant: -8),
                
                firstLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
                firstLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                
                // Row 2: First Button (center aligned)
                firstButton.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 20),
                firstButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                // Row 3: Two TextFields side by side
                secondTextField.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 20),
                secondTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
                secondTextField.trailingAnchor.constraint(equalTo: thirdTextField.leadingAnchor, constant: -8),
                
                thirdTextField.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 20),
                thirdTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
                thirdTextField.widthAnchor.constraint(equalToConstant: 64),
                
                // Row 4: Second Button (right aligned)
                secondButton.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 20),
                secondButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
                
                // Row 5: Fourth TextField
                fourthTextField.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 20),
                fourthTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
                fourthTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24)
            ])
        }
}
