//
//  ChatListView.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit

class ChatListView: UIView {
    
    var profileImageView: UIImageView!
    var welcomeLabel: UILabel!
    var segmentedControl: UISegmentedControl!
    var tableViewChats: UITableView!
    var floatingAddButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupProfileImageView()
        setupWelcomeLabel()
        setupSegmentedControl()
        setupTableViewChats()
        setupFloatingAddButton()
        
        initConstraints()
    }
    
    func setupProfileImageView() {
        profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .systemGray
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImageView)
    }
    
    func setupWelcomeLabel() {
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome!"
        welcomeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        welcomeLabel.textColor = .label
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(welcomeLabel)
    }
    
    func setupSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["Chats", "Groups", "All Users"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(segmentedControl)
    }
    
    func setupTableViewChats() {
        tableViewChats = UITableView()
        tableViewChats.register(ChatListTableViewCell.self, forCellReuseIdentifier: "ChatListCell")
        tableViewChats.rowHeight = 75
        tableViewChats.separatorStyle = .none
        tableViewChats.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewChats)
    }
    
    func setupFloatingAddButton() {
        floatingAddButton = UIButton(type: .system)
        floatingAddButton.setImage(UIImage(systemName: "plus.message.fill"), for: .normal)
        floatingAddButton.tintColor = .white
        floatingAddButton.backgroundColor = .systemBlue
        floatingAddButton.layer.cornerRadius = 28
        floatingAddButton.layer.shadowColor = UIColor.black.cgColor
        floatingAddButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        floatingAddButton.layer.shadowRadius = 4
        floatingAddButton.layer.shadowOpacity = 0.3
        floatingAddButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingAddButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            welcomeLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            welcomeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            segmentedControl.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            tableViewChats.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableViewChats.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewChats.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewChats.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            floatingAddButton.widthAnchor.constraint(equalToConstant: 56),
            floatingAddButton.heightAnchor.constraint(equalToConstant: 56),
            floatingAddButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            floatingAddButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
