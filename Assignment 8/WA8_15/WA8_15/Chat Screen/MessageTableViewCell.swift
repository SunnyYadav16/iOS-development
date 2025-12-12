//
//  MessageTableViewCell.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    var bubbleView: UIView!
    var messageLabel: UILabel!
    var timeLabel: UILabel!
    var senderNameLabel: UILabel!
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setupBubbleView()
        setupSenderNameLabel()
        setupMessageLabel()
        setupTimeLabel()
        
        initConstraints()
    }
    
    func setupBubbleView() {
        bubbleView = UIView()
        bubbleView.layer.cornerRadius = 16
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bubbleView)
    }
    
    func setupSenderNameLabel() {
        senderNameLabel = UILabel()
        senderNameLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        senderNameLabel.textColor = .systemBlue
        senderNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(senderNameLabel)
    }
    
    func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(messageLabel)
    }
    
    func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 11)
        timeLabel.textColor = .secondaryLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)
    }
    
    func initConstraints() {
        leadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        trailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bubbleView.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -2),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            senderNameLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
            senderNameLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
            senderNameLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),
            
            messageLabel.topAnchor.constraint(equalTo: senderNameLabel.bottomAnchor, constant: 2),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8),
            
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            timeLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func configure(with message: Message, isMyMessage: Bool, showSenderName: Bool = false) {
        messageLabel.text = message.text
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        timeLabel.text = formatter.string(from: message.timestamp)
        
        if showSenderName {
            senderNameLabel.text = message.senderName
            senderNameLabel.isHidden = false
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: senderNameLabel.bottomAnchor, constant: 2)
            ])
        } else {
            senderNameLabel.isHidden = true
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8)
            ])
        }
        
        if isMyMessage {
            bubbleView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
            
            leadingConstraint.isActive = false
            trailingConstraint.isActive = true
            
            timeLabel.textAlignment = .right
            NSLayoutConstraint.activate([
                timeLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor)
            ])
        } else {
            bubbleView.backgroundColor = .systemGray5
            messageLabel.textColor = .label
            
            trailingConstraint.isActive = false
            leadingConstraint.isActive = true
            
            timeLabel.textAlignment = .left
            NSLayoutConstraint.activate([
                timeLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor)
            ])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        senderNameLabel.text = nil
        senderNameLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
