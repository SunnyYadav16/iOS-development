//
//  ChatView.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit

class ChatView: UIView {
    
    var tableViewMessages: UITableView!
    var messageInputContainer: UIView!
    var textFieldMessage: UITextField!
    var buttonSend: UIButton!
    var bottomConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupTableViewMessages()
        setupMessageInputContainer()
        setupTextFieldMessage()
        setupButtonSend()
        
        initConstraints()
    }
    
    func setupTableViewMessages() {
        tableViewMessages = UITableView()
        tableViewMessages.backgroundColor = .systemBackground
        tableViewMessages.separatorStyle = .none
        tableViewMessages.allowsSelection = false
        tableViewMessages.keyboardDismissMode = .interactive

        tableViewMessages.register(MessageTableViewCell.self, forCellReuseIdentifier: "MyMessageCell")
        tableViewMessages.register(MessageTableViewCell.self, forCellReuseIdentifier: "TheirMessageCell")
        
        tableViewMessages.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewMessages)
    }
    
    func setupMessageInputContainer() {
        messageInputContainer = UIView()
        messageInputContainer.backgroundColor = .systemBackground
        messageInputContainer.layer.borderColor = UIColor.systemGray4.cgColor
        messageInputContainer.layer.borderWidth = 0.5
        messageInputContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messageInputContainer)
    }
    
    func setupTextFieldMessage() {
        textFieldMessage = UITextField()
        textFieldMessage.placeholder = "Type a message..."
        textFieldMessage.borderStyle = .roundedRect
        textFieldMessage.backgroundColor = .systemGray6
        textFieldMessage.font = .systemFont(ofSize: 16)
        textFieldMessage.translatesAutoresizingMaskIntoConstraints = false
        messageInputContainer.addSubview(textFieldMessage)
    }
    
    func setupButtonSend() {
        buttonSend = UIButton(type: .system)
        buttonSend.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        buttonSend.tintColor = .systemBlue
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        messageInputContainer.addSubview(buttonSend)
    }
    
    func initConstraints() {
        bottomConstraint = messageInputContainer.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            messageInputContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            messageInputContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomConstraint!,
            messageInputContainer.heightAnchor.constraint(equalToConstant: 60),
            
            textFieldMessage.leadingAnchor.constraint(equalTo: messageInputContainer.leadingAnchor, constant: 12),
            textFieldMessage.centerYAnchor.constraint(equalTo: messageInputContainer.centerYAnchor),
            textFieldMessage.trailingAnchor.constraint(equalTo: buttonSend.leadingAnchor, constant: -8),
            textFieldMessage.heightAnchor.constraint(equalToConstant: 40),
            
            buttonSend.trailingAnchor.constraint(equalTo: messageInputContainer.trailingAnchor, constant: -12),
            buttonSend.centerYAnchor.constraint(equalTo: messageInputContainer.centerYAnchor),
            buttonSend.widthAnchor.constraint(equalToConstant: 40),
            buttonSend.heightAnchor.constraint(equalToConstant: 40),
            
            tableViewMessages.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableViewMessages.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewMessages.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewMessages.bottomAnchor.constraint(equalTo: messageInputContainer.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
