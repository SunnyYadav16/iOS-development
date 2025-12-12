//
//  CreateGroupViewController.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/5/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CreateGroupViewController: UIViewController {
    
    let createGroupView = CreateGroupView()
    let database = Firestore.firestore()
    
    var allUsers: [ChatUser] = []
    var selectedUsers: Set<String> = []
    var currentUser: User?
    
    override func loadView() {
        view = createGroupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Group"
        currentUser = Auth.auth().currentUser
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Create",
            style: .done,
            target: self,
            action: #selector(createTapped)
        )
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        createGroupView.tableViewUsers.delegate = self
        createGroupView.tableViewUsers.dataSource = self
        
        createGroupView.textFieldGroupName.delegate = self
        createGroupView.textFieldGroupName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        hideKeyboardOnTapOutside()
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc func createTapped() {
        guard let groupName = createGroupView.textFieldGroupName.text,
              !groupName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !selectedUsers.isEmpty,
              let currentEmail = currentUser?.email else { return }
        
        let loadingAlert = UIAlertController(title: "Creating Group", message: "Please wait...", preferredStyle: .alert)
        present(loadingAlert, animated: true)
        
        let groupId = UUID().uuidString
        
        var participants = Array(selectedUsers)
        participants.append(currentEmail)
        
        let batch = database.batch()
        
        let groupRef = database.collection("groups").document(groupId)
        let groupData: [String: Any] = [
            "groupName": groupName,
            "createdBy": currentEmail,
            "createdAt": FieldValue.serverTimestamp(),
            "participants": participants,
            "lastMessage": "Group created",
            "lastMessageTime": FieldValue.serverTimestamp(),
            "lastMessageSender": "system"
        ]
        batch.setData(groupData, forDocument: groupRef)
        
        let messageRef = database.collection("groups")
            .document(groupId)
            .collection("messages")
            .document()
        
        let initialMessage: [String: Any] = [
            "text": "Group '\(groupName)' was created",
            "senderId": "system",
            "senderName": "System",
            "timestamp": FieldValue.serverTimestamp(),
            "isRead": false
        ]
        batch.setData(initialMessage, forDocument: messageRef)
        
        for participant in participants {
            let userChatRef = database.collection("userChats")
                .document(participant)
                .collection("chats")
                .document(groupId)
            
            let userChatData: [String: Any] = [
                "type": "group",
                "name": groupName,
                "lastMessage": "Group created",
                "lastMessageTime": FieldValue.serverTimestamp(),
                "unreadCount": participant == currentEmail ? 0 : 1
            ]
            batch.setData(userChatData, forDocument: userChatRef)
        }
        
        batch.commit { error in
            loadingAlert.dismiss(animated: true) {
                if let error = error {
                    self.showAlert(title: "Error", message: "Failed to create group: \(error.localizedDescription)")
                } else {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @objc func textFieldChanged() {
        updateCreateButtonState()
    }
    
    func updateCreateButtonState() {
        let hasGroupName = !(createGroupView.textFieldGroupName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let hasSelectedUsers = !selectedUsers.isEmpty
        navigationItem.rightBarButtonItem?.isEnabled = hasGroupName && hasSelectedUsers
    }
}

extension CreateGroupViewController: AlertProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension CreateGroupViewController: KeyboardProtocol {
    func hideKeyboardOnTapOutside(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}
