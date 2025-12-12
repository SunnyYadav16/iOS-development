//
//  CreateGroupViewTableManager.swift
//  WA8_15
//
//  Created by Sunny Yadav on 11/5/25.
//

import Foundation
import UIKit

extension CreateGroupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        
        let user = allUsers[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        if selectedUsers.contains(user.email) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = allUsers[indexPath.row]
        
        if selectedUsers.contains(user.email) {
            selectedUsers.remove(user.email)
        } else {
            selectedUsers.insert(user.email)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        updateCreateButtonState()
    }
}

extension CreateGroupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

