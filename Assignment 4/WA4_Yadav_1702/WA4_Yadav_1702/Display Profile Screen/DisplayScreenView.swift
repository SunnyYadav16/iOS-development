//
//  DisplayScreenView.swift
//  WA4_Yadav_1702
//
//  Created by Sunny Yadav on 10/7/25.
//

import UIKit

class DisplayScreenView: UIView {
    
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    var addressHeaderLabel: UILabel!
    var addressLabel: UILabel!
    var cityStateLabel: UILabel!
    var zipCodeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUpNameLabel()
        setUpEmailLabel()
        setUpPhoneLabel()
        setUpAddressHeaderLabel()
        setUpAddressLabel()
        setUpCityStateLabel()
        setUpZipCodeLabel()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 28)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.textAlignment = .center
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    func setUpPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.textAlignment = .center
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneLabel)
    }
    
    func setUpAddressHeaderLabel() {
        addressHeaderLabel = UILabel()
        addressHeaderLabel.textAlignment = .center
        addressHeaderLabel.font = UIFont.boldSystemFont(ofSize: 20) 
        addressHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressHeaderLabel)
    }
    
    func setUpAddressLabel() {
        addressLabel = UILabel()
        addressLabel.textAlignment = .center
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressLabel)
    }
    
    func setUpCityStateLabel() {
        cityStateLabel = UILabel()
        cityStateLabel.textAlignment = .center
        cityStateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityStateLabel)
    }
    
    func setUpZipCodeLabel() {
        zipCodeLabel = UILabel()
        zipCodeLabel.textAlignment = .center
        zipCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipCodeLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Name label
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // Email label
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            emailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // Phone label
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            phoneLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            phoneLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // Address header label
            addressHeaderLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 24),
            addressHeaderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addressHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            addressHeaderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // Address label
            addressLabel.topAnchor.constraint(equalTo: addressHeaderLabel.bottomAnchor, constant: 8),
            addressLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // City, State label
            cityStateLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4),
            cityStateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cityStateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            cityStateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // Zip code label
            zipCodeLabel.topAnchor.constraint(equalTo: cityStateLabel.bottomAnchor, constant: 4),
            zipCodeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            zipCodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            zipCodeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
}
