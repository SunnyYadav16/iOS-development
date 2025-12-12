//
//  Protocols.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import UIKit

protocol NotesAPIProtocol {
    func getAllNotes()
    func deleteNote(noteId: String, at indexPath: IndexPath)
}

protocol NotesAddAPIProtocol {
    func addNote(title: String, text: String)
}

protocol ProfileAPIProtocol {
    func getUserProfile()
}

protocol KeyboardProtocol {
    func hideKeyboardOnTapOutside()
    func hideKeyboardOnTap()
}

protocol AlertProtocol {
    func showAlert(title: String, message: String)
}
