//
//  ChatViewController.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    let chatView = ChatView()
    let database = Firestore.firestore()
    
    var chatId: String!
    var chatName: String!
    var isGroupChat: Bool = false
    var currentUser: User?
    
    var messages: [Message] = []
    var messageListener: ListenerRegistration?
    
    override func loadView() {
        view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = chatName
        navigationController?.navigationBar.prefersLargeTitles = false
        
        chatView.tableViewMessages.delegate = self
        chatView.tableViewMessages.dataSource = self
        
        chatView.buttonSend.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        chatView.textFieldMessage.delegate = self
        
        loadMessages()
        hideKeyboardOnTapOutside()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        messageListener?.remove()
    }
    
    func loadMessages() {
        let collection = isGroupChat ? "groups" : "chats"
        
        messageListener = database.collection(collection)
            .document(chatId)
            .collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error loading messages: \(error)")
                    return
                }
                
                self.messages = []
                snapshot?.documents.forEach { document in
                    let data = document.data()
                    let message = Message(
                        id: document.documentID,
                        text: data["text"] as? String ?? "",
                        senderId: data["senderId"] as? String ?? "",
                        senderName: data["senderName"] as? String ?? "",
                        timestamp: (data["timestamp"] as? Timestamp)?.dateValue() ?? Date(),
                        isRead: data["isRead"] as? Bool ?? false
                    )
                    self.messages.append(message)
                }
                
                self.chatView.tableViewMessages.reloadData()
                self.scrollToBottom()
                self.markMessagesAsRead()
            }
    }
    
    func scrollToBottom() {
        if messages.count > 0 {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            chatView.tableViewMessages.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func markMessagesAsRead() {
        guard let currentEmail = currentUser?.email else { return }
        
        database.collection("userChats")
            .document(currentEmail)
            .collection("chats")
            .document(chatId)
            .updateData(["unreadCount": 0]) { error in
                if let error = error {
                    print("Error updating unread count: \(error)")
                }
            }
    }
    
    @objc func sendButtonTapped() {
        guard let text = chatView.textFieldMessage.text,
              !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let currentEmail = currentUser?.email,
              let currentName = currentUser?.displayName else { return }
        
        chatView.textFieldMessage.text = ""
        
        let messageData: [String: Any] = [
            "text": text,
            "senderId": currentEmail,
            "senderName": currentName,
            "timestamp": FieldValue.serverTimestamp(),
            "isRead": false
        ]
        
        let collection = isGroupChat ? "groups" : "chats"
        
        let batch = database.batch()
        
        let messageRef = database.collection(collection)
            .document(chatId)
            .collection("messages")
            .document()
        batch.setData(messageData, forDocument: messageRef)
        
        let chatRef = database.collection(collection).document(chatId)
        let chatUpdateData: [String: Any] = [
            "lastMessage": text,
            "lastMessageTime": FieldValue.serverTimestamp(),
            "lastMessageSender": currentEmail
        ]
        batch.updateData(chatUpdateData, forDocument: chatRef)
        
        batch.commit { error in
            if let error = error {
                print("Error sending message: \(error)")
            } else {
                self.updateUserChats(lastMessage: text, senderEmail: currentEmail)
            }
        }
    }
    
    func updateUserChats(lastMessage: String, senderEmail: String) {
        let collection = isGroupChat ? "groups" : "chats"
        
        database.collection(collection).document(chatId).getDocument { [weak self] document, error in
            guard let self = self,
                  let data = document?.data(),
                  let participants = data["participants"] as? [String] else {
                print("Error getting participants: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            for participant in participants {
                var updateData: [String: Any] = [
                    "lastMessage": lastMessage,
                    "lastMessageTime": FieldValue.serverTimestamp()
                ]
                
                if participant != senderEmail {
                    updateData["unreadCount"] = FieldValue.increment(Int64(1))
                }
                
                let userChatRef = self.database.collection("userChats")
                    .document(participant)
                    .collection("chats")
                    .document(self.chatId)
                
                userChatRef.getDocument { document, error in
                    if document?.exists == true {
                        // Update existing chat
                        userChatRef.updateData(updateData) { error in
                            if let error = error {
                                print("Error updating user chat for \(participant): \(error)")
                            }
                        }
                    } else {
                        var chatData = updateData
                        chatData["type"] = self.isGroupChat ? "group" : "direct"
                        chatData["name"] = self.chatName
                        chatData["unreadCount"] = participant == senderEmail ? 0 : 1
                        
                        userChatRef.setData(chatData) { error in
                            if let error = error {
                                print("Error creating user chat for \(participant): \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ChatViewController: KeyboardProtocol {
    func hideKeyboardOnTapOutside(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}
