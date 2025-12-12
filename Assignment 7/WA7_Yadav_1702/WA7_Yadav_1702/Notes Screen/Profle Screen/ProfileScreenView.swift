//
//  ProfileScreenView.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import UIKit

class ProfileScreenView: UIView {
    
    var detailContentWrapper: UIScrollView!
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setUpDetailContentWrapper()
        setUpNameLabel()
        setupEmailLabel()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpDetailContentWrapper(){
        detailContentWrapper = UIScrollView()
        detailContentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailContentWrapper)
    }
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        detailContentWrapper.addSubview(nameLabel)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = .systemFont(ofSize: 18, weight: .regular)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailContentWrapper.addSubview(emailLabel)
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
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: detailContentWrapper.leadingAnchor, constant: 20),
            emailLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            emailLabel.bottomAnchor.constraint(equalTo: detailContentWrapper.bottomAnchor, constant: -40)
        ])
    }
}
