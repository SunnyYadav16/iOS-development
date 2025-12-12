//
//  ChatViewTableManager.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import Foundation
import UIKit

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let isMyMessage = message.senderId == currentUser?.email
        
        let cellIdentifier = isMyMessage ? "MyMessageCell" : "TheirMessageCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MessageTableViewCell
        
        cell.configure(with: message, isMyMessage: isMyMessage, showSenderName: isGroupChat && !isMyMessage)
        
        return cell
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonTapped()
        return true
    }
}
