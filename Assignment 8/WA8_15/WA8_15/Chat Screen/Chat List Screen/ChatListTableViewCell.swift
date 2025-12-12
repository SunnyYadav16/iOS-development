//
//  ChatListTableViewCell.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var messageLabel: UILabel!
    var timeLabel: UILabel!
    var unreadBadge: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setupWrapperCellView()
        setupProfileImageView()
        setupNameLabel()
        setupMessageLabel()
        setupTimeLabel()
        setupUnreadBadge()
        
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .systemBackground
        wrapperCellView.layer.cornerRadius = 8
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupProfileImageView() {
        profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .systemGray3
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(profileImageView)
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(nameLabel)
    }
    
    func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .secondaryLabel
        messageLabel.numberOfLines = 1
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(messageLabel)
    }
    
    func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .tertiaryLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(timeLabel)
    }
    
    func setupUnreadBadge() {
        unreadBadge = UILabel()
        unreadBadge.font = .systemFont(ofSize: 12, weight: .bold)
        unreadBadge.textColor = .white
        unreadBadge.backgroundColor = .systemBlue
        unreadBadge.textAlignment = .center
        unreadBadge.layer.cornerRadius = 10
        unreadBadge.clipsToBounds = true
        unreadBadge.isHidden = true
        unreadBadge.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(unreadBadge)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
            profileImageView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 12),
            profileImageView.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: timeLabel.leadingAnchor, constant: -8),
            
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            messageLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: unreadBadge.leadingAnchor, constant: -8),
            
            timeLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 12),
            timeLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -12),
            
            unreadBadge.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            unreadBadge.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -12),
            unreadBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            unreadBadge.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with name: String, message: String, time: String, unreadCount: Int = 0, imageURL: String? = nil) {
        nameLabel.text = name
        messageLabel.text = message
        timeLabel.text = time
        
        if unreadCount > 0 {
            unreadBadge.isHidden = false
            unreadBadge.text = unreadCount > 99 ? "99+" : "\(unreadCount)"
        } else {
            unreadBadge.isHidden = true
        }
        
        if let urlString = imageURL, let url = URL(string: urlString) {
            loadImage(from: url)
        }
    }
    
    private func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.profileImageView.image = image
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
