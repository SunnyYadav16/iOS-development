//
//  NoteStructure.swift
//  Working with APIs
//
//  Created by Sunny Yadav on 10/29/25.
//

import Foundation

struct Note: Codable {
    var _id: String
    var userId: String
    var text: String
    
    init(_id: String, userId: String, text: String) {
        self._id = _id
        self.userId = userId
        self.text = text
    }
}

struct NotesData: Codable {
    var notes: [Note]
}
