//
//  CreateGroupView.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/5/25.
//

import UIKit

class CreateGroupView: UIView {
    
    var textFieldGroupName: UITextField!
    var labelSelectUsers: UILabel!
    var tableViewUsers: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupTextFieldGroupName()
        setupLabelSelectUsers()
        setupTableViewUsers()
        
        initConstraints()
    }
    
    func setupTextFieldGroupName() {
        textFieldGroupName = UITextField()
        textFieldGroupName.placeholder = "Group Name"
        textFieldGroupName.borderStyle = .roundedRect
        textFieldGroupName.backgroundColor = .systemGray6
        textFieldGroupName.font = .systemFont(ofSize: 16)
        textFieldGroupName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldGroupName)
    }
    
    func setupLabelSelectUsers() {
        labelSelectUsers = UILabel()
        labelSelectUsers.text = "Select Participants"
        labelSelectUsers.font = .systemFont(ofSize: 16, weight: .semibold)
        labelSelectUsers.textColor = .label
        labelSelectUsers.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSelectUsers)
    }
    
    func setupTableViewUsers() {
        tableViewUsers = UITableView()
        tableViewUsers.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableViewUsers.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewUsers)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            textFieldGroupName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            textFieldGroupName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldGroupName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldGroupName.heightAnchor.constraint(equalToConstant: 44),
            
            labelSelectUsers.topAnchor.constraint(equalTo: textFieldGroupName.bottomAnchor, constant: 30),
            labelSelectUsers.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            labelSelectUsers.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            tableViewUsers.topAnchor.constraint(equalTo: labelSelectUsers.bottomAnchor, constant: 12),
            tableViewUsers.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewUsers.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewUsers.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
