//
//  Chat.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/1/25.
//

import Foundation

struct ChatUser {
    let email: String
    let name: String
    let photoURL: String?
}

struct Chat {
    let id: String
    let name: String
    let lastMessage: String
    let lastMessageTime: Date
    let unreadCount: Int
    let photoURL: String?
}

struct GroupChat {
    let id: String
    let name: String
    let lastMessage: String
    let lastMessageTime: Date
    let unreadCount: Int
}
