//
//  DisplayView.swift
//  WA3_Yadav_1702
//
//  Created by Sunny Yadav on 9/30/25.
//

import UIKit

class DisplayView: UIView {

    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    var addressLabel: UILabel!
    var cityStateLabel: UILabel!
    var zipLabel: UILabel!
    var phoneImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setUpNameLabel()
        setUpEmailLabel()
        setUpPhoneLabel()
        setUpAddressLabel()
        setUpCityStateLabel()
        setUpZipCodeLabel()
        setUpPhoneImageView()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailLabel.textAlignment = .left
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    func setUpPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        phoneLabel.textAlignment = .left
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneLabel)
    }
 
    func setUpAddressLabel() {
        addressLabel = UILabel()
        addressLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        addressLabel.textAlignment = .left
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressLabel)
    }
    
    func setUpCityStateLabel() {
        cityStateLabel = UILabel()
        cityStateLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        cityStateLabel.textAlignment = .left
        cityStateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityStateLabel)
    }
    
    func setUpZipCodeLabel() {
        zipLabel = UILabel()
        zipLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        zipLabel.textAlignment = .left
        zipLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipLabel)
    }
    
    func setUpPhoneImageView() {
        phoneImageView = UIImageView()
        phoneImageView.tintColor = .black
        phoneImageView.contentMode = .scaleAspectFit
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneImageView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Name Label
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Email Label
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            emailLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Phone Label
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            phoneLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Address Label
            addressLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            addressLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // City State Label
            cityStateLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            cityStateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            cityStateLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // ZIP Label
            zipLabel.topAnchor.constraint(equalTo: cityStateLabel.bottomAnchor, constant: 20),
            zipLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            zipLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Phone Image View
            phoneImageView.topAnchor.constraint(equalTo: zipLabel.bottomAnchor, constant: 60),
            phoneImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            phoneImageView.widthAnchor.constraint(equalToConstant: 50),
            phoneImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
