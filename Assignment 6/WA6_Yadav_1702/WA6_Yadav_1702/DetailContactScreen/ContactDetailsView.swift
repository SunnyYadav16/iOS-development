//
//  ContactDetailsView.swift
//  Working with APIs
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit

class ContactDetailsView: UIView {
    
    var detailContentWrapper:UIScrollView!
    var nameLabel: UILabel!
    var nameValueLabel: UILabel!
    var emailLabel: UILabel!
    var emailValueLabel: UILabel!
    var phoneLabel: UILabel!
    var phoneValueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setUpDetailContentWrapper()
        setUpNameLabel()
        setUpNameValueLabel()
        setupEmailLabel()
        setupEmailValueLabel()
        setUpPhoneLabel()
        setUpPhoneValueLabel()
        initConstraints()
    }
    
    func setUpDetailContentWrapper(){
        detailContentWrapper = UIScrollView()
        detailContentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailContentWrapper)
    }
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = "Name:"
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.textColor = .secondaryLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        detailContentWrapper.addSubview(nameLabel)
    }
    
    func setUpNameValueLabel() {
        nameValueLabel = UILabel()
        nameValueLabel.font = .systemFont(ofSize: 18, weight: .regular)
        nameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        detailContentWrapper.addSubview(nameValueLabel)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "Email:"
        emailLabel.font = .systemFont(ofSize: 16, weight: .medium)
        emailLabel.textColor = .secondaryLabel
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailContentWrapper.addSubview(emailLabel)
    }
    
    func setupEmailValueLabel() {
        emailValueLabel = UILabel()
        emailValueLabel.font = .systemFont(ofSize: 18, weight: .regular)
        emailValueLabel.translatesAutoresizingMaskIntoConstraints = false
        detailContentWrapper.addSubview(emailValueLabel)
    }
    
    func setUpPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.text = "Phone:"
        phoneLabel.font = .systemFont(ofSize: 16, weight: .medium)
        phoneLabel.textColor = .secondaryLabel
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        detailContentWrapper.addSubview(phoneLabel)
    }
    
    func setUpPhoneValueLabel() {
        phoneValueLabel = UILabel()
        phoneValueLabel.font = .systemFont(ofSize: 18, weight: .regular)
        phoneValueLabel.translatesAutoresizingMaskIntoConstraints = false
        detailContentWrapper.addSubview(phoneValueLabel)
    }
        
    func initConstraints() {
        NSLayoutConstraint.activate([
            detailContentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            detailContentWrapper.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detailContentWrapper.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            detailContentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: detailContentWrapper.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: detailContentWrapper.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            nameValueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            nameValueLabel.leadingAnchor.constraint(equalTo: detailContentWrapper.leadingAnchor, constant: 20),
            nameValueLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            emailLabel.topAnchor.constraint(equalTo: nameValueLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: detailContentWrapper.leadingAnchor, constant: 20),
            emailLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            emailValueLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            emailValueLabel.leadingAnchor.constraint(equalTo: detailContentWrapper.leadingAnchor, constant: 20),
            emailValueLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            phoneLabel.topAnchor.constraint(equalTo: emailValueLabel.bottomAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: detailContentWrapper.leadingAnchor, constant: 20),
            phoneLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            
            phoneValueLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4),
            phoneValueLabel.leadingAnchor.constraint(equalTo: detailContentWrapper.leadingAnchor, constant: 20),
            phoneValueLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            phoneValueLabel.bottomAnchor.constraint(equalTo: detailContentWrapper.bottomAnchor, constant: -40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
