//
//  FirstView.swift
//  WA_3_1_3_1702
//
//  Created by Sunny Yadav on 9/26/25.
//

import UIKit

class FirstView: UIView {
    
    var firstLabel: UILabel!
    var secondLabel: UILabel!
    var thirdLabel: UILabel!
    var fourthLabel: UILabel!
    
    var firstButton: UIButton!
    var secondButton: UIButton!
    var thirdButton: UIButton!
    var fourthButton: UIButton!
    var fifthButton: UIButton!
    var sixthButton: UIButton!
    
    var firstTextField: UITextField!
    var secondTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        //MARK: initializing the UI elements and constraints...
        setUpFirstLabel()
        setUpSecondLabel()
        setUpThirdLabel()
        setUpFourthLabel()
        
        setUpFirstButton()
        setUpSecondButton()
        setUpThirdButton()
        setUpFourthButton()
        setUpFifthButton()
        setUpSixthButton()
        
        setUpFirstTextField()
        setUpSecondTextField()
        
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
    
    func setUpSecondLabel() {
        secondLabel = UILabel()
        secondLabel.text = "Label"
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(secondLabel)
    }
    
    func setUpThirdLabel() {
        thirdLabel = UILabel()
        thirdLabel.text = "Label"
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(thirdLabel)
    }
    
    func setUpFourthLabel() {
        fourthLabel = UILabel()
        fourthLabel.text = "Label"
        fourthLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fourthLabel)
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
    
    func setUpThirdButton() {
        thirdButton = UIButton(type: .system)
        thirdButton.setTitle( "Button", for: .normal)
        thirdButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(thirdButton)
    }
    
    func setUpFourthButton() {
        fourthButton = UIButton(type: .system)
        fourthButton.setTitle( "Button", for: .normal)
        fourthButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        fourthButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fourthButton)
    }
    
    func setUpFifthButton() {
        fifthButton = UIButton(type: .system)
        fifthButton.setTitle( "Button", for: .normal)
        fifthButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        fifthButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fifthButton)
    }
    
    func setUpSixthButton() {
        sixthButton = UIButton(type: .system)
        sixthButton.setTitle( "Button", for: .normal)
        sixthButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        sixthButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sixthButton)
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
    
    func initConstraints() {
            NSLayoutConstraint.activate([
                // Row 1: TextField spanning most of the width
                firstTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
                firstTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                firstTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),

                // Row 2: Three labels evenly distributed
                firstLabel.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 24),
                firstLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),

                secondLabel.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 24),
                secondLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                secondLabel.widthAnchor.constraint(equalTo: firstLabel.widthAnchor),

                thirdLabel.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 24),
                thirdLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                thirdLabel.widthAnchor.constraint(equalTo: firstLabel.widthAnchor),

                // Row 3: First button on the left
                firstButton.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 30),
                firstButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                
                // Row 4: Second button on the left
                secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 20),
                secondButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                
                // Row 5: Third button centered
                thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 30),
                thirdButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                // Row 6: Two buttons on the right
                fourthButton.topAnchor.constraint(equalTo: thirdButton.bottomAnchor, constant: 30),
                fourthButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                fifthButton.topAnchor.constraint(equalTo: fourthButton.bottomAnchor, constant: 10),
                fifthButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                // Row 7: Label centered
                fourthLabel.topAnchor.constraint(equalTo: fifthButton.bottomAnchor, constant: 40),
                fourthLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                // Row 8 (Last row): Button on left, TextField on right
                secondTextField.topAnchor.constraint(equalTo: fourthLabel.bottomAnchor, constant: 40),
                secondTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                secondTextField.widthAnchor.constraint(equalToConstant: 150),
                
                sixthButton.topAnchor.constraint(equalTo: fourthLabel.bottomAnchor, constant: 40),
                sixthButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                sixthButton.trailingAnchor.constraint(equalTo: secondTextField.leadingAnchor, constant: -20),
                sixthButton.widthAnchor.constraint(equalTo: secondTextField.widthAnchor),

            ])
        }

}
