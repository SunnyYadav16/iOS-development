//
//  ChatListTableViewManager.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import Foundation
import UIKit
import FirebaseFirestore

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentSegment {
        case 0: return directChats.count
        case 1: return groups.count
        case 2: return allUsers.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListTableViewCell
        
        switch currentSegment {
        case 0: // Direct Chats
            let chat = directChats[indexPath.row]
            cell.configure(
                with: chat.name,
                message: chat.lastMessage,
                time: formatTime(chat.lastMessageTime),
                unreadCount: chat.unreadCount,
                imageURL: chat.photoURL
            )
            
        case 1: // Groups
            let group = groups[indexPath.row]
            cell.configure(
                with: group.name,
                message: group.lastMessage,
                time: formatTime(group.lastMessageTime),
                unreadCount: group.unreadCount
            )
            cell.profileImageView.image = UIImage(systemName: "person.3.fill")
            
        case 2: // All Users
            let user = allUsers[indexPath.row]
            cell.configure(
                with: user.name,
                message: user.email,
                time: "",
                unreadCount: 0,
                imageURL: user.photoURL
            )
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch currentSegment {
        case 0: // Direct Chats
            let chat = directChats[indexPath.row]
            openChat(chatId: chat.id, chatName: chat.name, isGroup: false)
            
        case 1: // Groups
            let group = groups[indexPath.row]
            openChat(chatId: group.id, chatName: group.name, isGroup: true)
            
        case 2: // All Users
            let user = allUsers[indexPath.row]
            startNewChat(with: user)
            
        default:
            break
        }
    }
    
    func openChat(chatId: String, chatName: String, isGroup: Bool) {
        let chatVC = ChatViewController()
        chatVC.chatId = chatId
        chatVC.chatName = chatName
        chatVC.isGroupChat = isGroup
        chatVC.currentUser = currentUser
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func startNewChat(with user: ChatUser) {
        guard let currentEmail = currentUser?.email else { return }
        
        let emails = [currentEmail, user.email].sorted()
        let chatId = emails.joined(separator: "_")
        
        database.collection("chats").document(chatId).getDocument { [weak self] document, error in
            if document?.exists == true {
                self?.openChat(chatId: chatId, chatName: user.name, isGroup: false)
            } else {
                self?.createNewChat(chatId: chatId, with: user)
            }
        }
    }
    
    func createNewChat(chatId: String, with user: ChatUser) {
        guard let currentEmail = currentUser?.email,
              let currentName = currentUser?.displayName else { return }
        
        let loadingAlert = UIAlertController(title: "Creating Chat", message: "Please wait...", preferredStyle: .alert)
        present(loadingAlert, animated: true)
        
        let batch = database.batch()
        
        let chatRef = database.collection("chats").document(chatId)
        let chatData: [String: Any] = [
            "participants": [currentEmail, user.email],
            "lastMessage": "",
            "lastMessageTime": FieldValue.serverTimestamp(),
            "lastMessageSender": ""
        ]
        batch.setData(chatData, forDocument: chatRef)
        
        let currentUserChatRef = database.collection("userChats")
            .document(currentEmail)
            .collection("chats")
            .document(chatId)
        
        let userChatData: [String: Any] = [
            "type": "direct",
            "name": user.name,
            "lastMessage": "",
            "lastMessageTime": FieldValue.serverTimestamp(),
            "unreadCount": 0,
            "photoURL": user.photoURL ?? ""
        ]
        batch.setData(userChatData, forDocument: currentUserChatRef)
        
        let otherUserChatRef = database.collection("userChats")
            .document(user.email)
            .collection("chats")
            .document(chatId)
        
        let otherUserChatData: [String: Any] = [
            "type": "direct",
            "name": currentName,
            "lastMessage": "",
            "lastMessageTime": FieldValue.serverTimestamp(),
            "unreadCount": 0,
            "photoURL": currentUser?.photoURL?.absoluteString ?? ""
        ]
        batch.setData(otherUserChatData, forDocument: otherUserChatRef)
        
        batch.commit { error in
            loadingAlert.dismiss(animated: true)
            
            if let error = error {
                print("Error creating chat: \(error)")
                self.showAlert(title: "Error", message: "Failed to create chat")
            } else {
                self.openChat(chatId: chatId, chatName: user.name, isGroup: false)
            }
        }
    }
}

extension ChatListViewController: AlertProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
