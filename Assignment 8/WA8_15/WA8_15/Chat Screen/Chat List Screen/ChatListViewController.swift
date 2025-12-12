//
//  ChatListViewController.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatListViewController: UIViewController {
    
    let chatListView = ChatListView()
    let database = Firestore.firestore()
    
    var currentUser: User?
    var allUsers: [ChatUser] = []
    var directChats: [Chat] = []
    var groups: [GroupChat] = []
    var currentSegment = 0
    
    override func loadView() {
        view = chatListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNavigationBar()
        
        chatListView.tableViewChats.delegate = self
        chatListView.tableViewChats.dataSource = self
        
        chatListView.segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        chatListView.floatingAddButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        currentUser = Auth.auth().currentUser
        updateUserInterface()
        
        loadAllUsers()
        observeDirectChats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupNavigationBar() {
        let logoutButton = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    func updateUserInterface() {
        if let user = currentUser {
            chatListView.welcomeLabel.text = "Welcome, \(user.displayName ?? "User")!"
            
            if let photoURL = user.photoURL {
                loadProfileImage(from: photoURL)
            }
        }
    }
    
    func loadProfileImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.chatListView.profileImageView.image = image
                    }
                }
            }
        }
    }
    
    
    func loadAllUsers() {
        guard let currentEmail = currentUser?.email else { return }
        
        database.collection("users")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error loading users: \(error)")
                    return
                }
                
                self.allUsers = []
                snapshot?.documents.forEach { document in
                    let data = document.data()
                    if let email = data["email"] as? String,
                       email != currentEmail {
                        let user = ChatUser(
                            email: email,
                            name: data["name"] as? String ?? "Unknown",
                            photoURL: data["photoURL"] as? String
                        )
                        self.allUsers.append(user)
                    }
                }
                
                if self.currentSegment == 2 {
                    self.chatListView.tableViewChats.reloadData()
                }
            }
    }
    
    func observeDirectChats() {
        guard let currentEmail = currentUser?.email else { return }
        
        database.collection("userChats")
            .document(currentEmail)
            .collection("chats")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error loading user chats: \(error)")
                    return
                }
                
                self.directChats = []
                self.groups = []
                
                snapshot?.documents.forEach { document in
                    let data = document.data()
                    let chatType = data["type"] as? String ?? "direct"
                    
                    if chatType == "direct" {
                        let chat = Chat(
                            id: document.documentID,
                            name: data["name"] as? String ?? "Unknown",
                            lastMessage: data["lastMessage"] as? String ?? "",
                            lastMessageTime: (data["lastMessageTime"] as? Timestamp)?.dateValue() ?? Date(),
                            unreadCount: data["unreadCount"] as? Int ?? 0,
                            photoURL: data["photoURL"] as? String
                        )
                        self.directChats.append(chat)
                        
                    } else if chatType == "group" {
                        let group = GroupChat(
                            id: document.documentID,
                            name: data["name"] as? String ?? "Unknown Group",
                            lastMessage: data["lastMessage"] as? String ?? "",
                            lastMessageTime: (data["lastMessageTime"] as? Timestamp)?.dateValue() ?? Date(),
                            unreadCount: data["unreadCount"] as? Int ?? 0
                        )
                        self.groups.append(group)
                    }
                }
                
                self.directChats.sort { $0.lastMessageTime > $1.lastMessageTime }
                self.groups.sort { $0.lastMessageTime > $1.lastMessageTime }
                
                self.chatListView.tableViewChats.reloadData()
            }
    }


    @objc func segmentChanged() {
        currentSegment = chatListView.segmentedControl.selectedSegmentIndex
        chatListView.tableViewChats.reloadData()
        
        switch currentSegment {
        case 1: // Groups
            chatListView.floatingAddButton.isHidden = false
            chatListView.floatingAddButton.setImage(UIImage(systemName: "person.3.fill"), for: .normal)
        case 2: // All Users
            chatListView.floatingAddButton.isHidden = true
        default: // Chats
            chatListView.floatingAddButton.isHidden = false
            chatListView.floatingAddButton.setImage(UIImage(systemName: "plus.message.fill"), for: .normal)
        }
    }
    
    @objc func addButtonTapped() {
        if currentSegment == 1 {
            createNewGroup()
        } else {
            chatListView.segmentedControl.selectedSegmentIndex = 2
            segmentChanged()
        }
    }
    
    @objc func logoutTapped() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { _ in
            do {
                try Auth.auth().signOut()
                self.navigateToLogin()
            } catch {
                print("Error signing out: \(error)")
            }
        })
        
        present(alert, animated: true)
    }
    
    func navigateToLogin() {
        let loginVC = ViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func createNewGroup() {
        let createGroupVC = CreateGroupViewController()
        createGroupVC.allUsers = self.allUsers
        let navController = UINavigationController(rootViewController: createGroupVC)
        present(navController, animated: true)
    }
    
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            formatter.dateFormat = "h:mm a"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if calendar.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
            formatter.dateFormat = "EEEE"
        } else {
            formatter.dateFormat = "MM/dd/yy"
        }
        
        return formatter.string(from: date)
    }
}
