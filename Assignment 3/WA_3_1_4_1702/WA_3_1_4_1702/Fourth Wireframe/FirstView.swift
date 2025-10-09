//
//  FirstView.swift
//  WA_3_1_4_1702
//
//  Created by Sunny Yadav on 9/26/25.
//

import UIKit

class FirstView: UIView {
    
    var firstButton: UIButton!
    var secondButton: UIButton!
    
    var firstTextField: UITextField!
    var secondTextField: UITextField!
    var thirdTextField: UITextField!
    var fourthTextField: UITextField!
    
    var firstLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        //MARK: initializing the UI elements and constraints...
        setUpFirstLabel()
        
        setUpFirstButton()
        setUpSecondButton()
        
        setUpFirstTextField()
        setUpSecondTextField()
        setUpThirdTextField()
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
    
    func setUpFirstButton() {
        firstButton = UIButton(type: .system)
        firstButton.setTitle("Button", for: .normal)
        firstButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstButton)
    }
    
    func setUpSecondButton() {
        secondButton = UIButton(type: .system)
        secondButton.setTitle( "Button", for: .normal)
        secondButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(secondButton)
    }
    
    func setUpFirstTextField() {
        firstTextField = UITextField()
        firstTextField.placeholder = "Aa"
        firstTextField.borderStyle = .roundedRect
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstTextField)
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
    
    func setUpFourthTextField() {
        fourthTextField = UITextField()
        fourthTextField.placeholder = "Aa"
        fourthTextField.borderStyle = .roundedRect
        fourthTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fourthTextField)
    }
    
    func initConstraints() {
            NSLayoutConstraint.activate([
                // Row 1: Button centered
                firstButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
                firstButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                // Row 2: Two TextFields with symmetric spacing
                firstTextField.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 60),
                firstTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                firstTextField.widthAnchor.constraint(equalToConstant: 48),
                
                secondTextField.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 60),
                secondTextField.leadingAnchor.constraint(equalTo: firstTextField.trailingAnchor, constant: 12),
                secondTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                // Row 3: Label centered
                firstLabel.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 25),
                firstLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                // Row 4: Two TextFields
                thirdTextField.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 160),
                thirdTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                thirdTextField.trailingAnchor.constraint(equalTo: fourthTextField.leadingAnchor, constant: -12),
                
                fourthTextField.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 160),
                fourthTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                fourthTextField.widthAnchor.constraint(equalToConstant: 48),
                
                // Row 5: Button centered
                secondButton.topAnchor.constraint(equalTo: thirdTextField.bottomAnchor, constant: 25),
                secondButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }
}
