//
//  ScrollScreenView.swift
//  Scroll View
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit

class ScrollScreenView: UIView {
    var contentWrapper:UIScrollView!
    var largeImageView:UIImageView!
    var textField1:UITextField!
    var textField2:UITextField!
    var textField3:UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupLargeImageView()
        setuptextField1()
        setuptextField2()
        setuptextField3()
        
        initConstraints()
    }
    
    //MARK: unused...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setting up UI elements...
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }

    func setuptextField1(){
        textField1 = UITextField()
        textField1.placeholder = "First Text Field"
        textField1.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textField1)
    }

    func setupLargeImageView(){
        largeImageView = UIImageView()
        largeImageView.image = UIImage(named: "image")
        largeImageView.contentMode = .scaleAspectFill
        largeImageView.clipsToBounds = true
        largeImageView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(largeImageView)
    }

    func setuptextField2(){
        textField2 = UITextField()
        textField2.placeholder = "Second Text Field"
        textField2.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textField2)
    }

    func setuptextField3(){
        textField3 = UITextField()
        textField3.placeholder = "Third Text Field"
        textField3.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textField3)
    }
    
    //MARK: initializing constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            //MARK: contentWrapper constraints...
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            //MARK: textField1 constraints...
            textField1.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 32),
            textField1.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            //MARK: largeImageView constraints...
            largeImageView.heightAnchor.constraint(equalToConstant: 800),
            largeImageView.widthAnchor.constraint(equalTo: contentWrapper.widthAnchor),
            largeImageView.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 8),
            largeImageView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            //MARK: textField2 constraints...
            textField2.topAnchor.constraint(equalTo: largeImageView.bottomAnchor, constant: 8),
            textField2.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            
            //MARK: textField3 constraints...
            textField3.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 8),
            textField3.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textField3.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor)
            

        ])
    }
}
