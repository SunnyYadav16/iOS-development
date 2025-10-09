//
//  FirstView.swift
//  WA_3_1_2_1702
//
//  Created by Sunny Yadav on 9/26/25.
//

import UIKit

class FirstView: UIView {
    
    var firstButton: UIButton!
    var secondButton: UIButton!
    var thirdButton: UIButton!
    var fourthButton: UIButton!
    var fifthButton: UIButton!
    var sixthButton: UIButton!
    var seventhButton: UIButton!
    var eighthButton: UIButton!
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        //MARK: initializing the UI elements and constraints...
        setUpFirstButton()
        setUpSecondButton()
        setUpThirdButton()
        setUpFourthButton()
        setUpFifthButton()
        setUpSixthButton()
        setUpSeventhButton()
        setUpEighthButton()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        thirdButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(thirdButton)
    }
    
    func setUpFourthButton() {
        fourthButton = UIButton(type: .system)
        fourthButton.setTitle( "Button", for: .normal)
        fourthButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        fourthButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fourthButton)
    }
    
    func setUpFifthButton() {
        fifthButton = UIButton(type: .system)
        fifthButton.setTitle( "Button", for: .normal)
        fifthButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        fifthButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fifthButton)
    }
    
    func setUpSixthButton() {
        sixthButton = UIButton(type: .system)
        sixthButton.setTitle( "Button", for: .normal)
        sixthButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sixthButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sixthButton)
    }
    
    func setUpSeventhButton() {
        seventhButton = UIButton(type: .system)
        seventhButton.setTitle( "Button", for: .normal)
        seventhButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        seventhButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(seventhButton)
    }
    
    func setUpEighthButton() {
        eighthButton = UIButton(type: .system)
        eighthButton.setTitle( "Button", for: .normal)
        eighthButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        eighthButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(eighthButton)
    }

    
    func initConstraints() {
            NSLayoutConstraint.activate([
                // Row 1: Two buttons with symmetrical leading and trailing anchors
                firstButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 48),
                firstButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                firstButton.widthAnchor.constraint(equalTo: secondButton.widthAnchor),
                firstButton.heightAnchor.constraint(equalToConstant: 50),
                
                secondButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 48),
                secondButton.leadingAnchor.constraint(equalTo: firstButton.trailingAnchor, constant: 20),
                secondButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                secondButton.heightAnchor.constraint(equalToConstant: 50),
                
                // Row 2: One button, center aligned
                thirdButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 25),
                thirdButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                thirdButton.heightAnchor.constraint(equalToConstant: 34),
                thirdButton.widthAnchor.constraint(equalToConstant: 100),
                
                // Row 3: Two smaller buttons
                fourthButton.topAnchor.constraint(equalTo: thirdButton.bottomAnchor, constant: 25),
                fourthButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                fourthButton.widthAnchor.constraint(equalTo: fifthButton.widthAnchor),
                fourthButton.heightAnchor.constraint(equalToConstant: 34),
                
                fifthButton.topAnchor.constraint(equalTo: thirdButton.bottomAnchor, constant: 25),
                fifthButton.leadingAnchor.constraint(equalTo: fourthButton.trailingAnchor, constant: 20),
                fifthButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                fifthButton.heightAnchor.constraint(equalToConstant: 34),
                
                // Row 4: Two buttons with larger leading and trailing anchors
                sixthButton.topAnchor.constraint(equalTo: fourthButton.bottomAnchor, constant: 25),
                sixthButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
                sixthButton.widthAnchor.constraint(equalTo: seventhButton.widthAnchor),
                sixthButton.heightAnchor.constraint(equalToConstant: 34),
                
                seventhButton.topAnchor.constraint(equalTo: fourthButton.bottomAnchor, constant: 25),
                seventhButton.leadingAnchor.constraint(equalTo: sixthButton.trailingAnchor, constant: 20),
                seventhButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                seventhButton.heightAnchor.constraint(equalToConstant: 34),
                
                // Row 5: One larger button, center aligned
                eighthButton.topAnchor.constraint(equalTo: sixthButton.bottomAnchor, constant: 25),
                eighthButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                eighthButton.heightAnchor.constraint(equalToConstant: 50),
                eighthButton.widthAnchor.constraint(equalToConstant: 120)
            ])
        }
}
