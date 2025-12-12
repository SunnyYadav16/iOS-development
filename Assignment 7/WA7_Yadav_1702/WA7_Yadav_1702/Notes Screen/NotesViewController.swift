//
//  NotesViewController.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import UIKit
import Alamofire

class NotesViewController: UIViewController {
    
    let notesScreen = NotesScreenView()
    var notes = [Note]()
        
    override func loadView() {
        view = notesScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        let logoutButton = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(onLogoutTapped)
        )
        
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle"),
            style: .plain,
            target: self,
            action: #selector(onProfileButtonTapped)
        )
        
        navigationItem.rightBarButtonItems = [logoutButton, profileButton]
        
        notesScreen.tableViewNotes.dataSource = self
        notesScreen.tableViewNotes.delegate = self
        notesScreen.tableViewNotes.separatorStyle = .none
        notesScreen.tableViewNotes.estimatedRowHeight = 80
        notesScreen.tableViewNotes.rowHeight = UITableView.automaticDimension
        
        notesScreen.addButton.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        
        getAllNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            getAllNotes()
        }
        
    @objc func onAddButtonTapped() {
        let addNoteVC = AddNoteViewController()
        navigationController?.pushViewController(addNoteVC, animated: true)
    }
    
    @objc func onProfileButtonTapped() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc func onLogoutTapped() {
        let alert = UIAlertController(
            title: "Logout",
            message: "Are you sure you want to logout?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { _ in
            self.performLogout()
        })
        
        present(alert, animated: true)
    }

    func navigateToLogin() {
        UserDefaults.standard.removeObject(forKey: "x-access-token")
        let loginVC = ViewController()
        navigationController?.setViewControllers([loginVC], animated: true)
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath) as! NotesTableView
        
        let note = notes[indexPath.row]
        cell.labelName.text = "Note \(indexPath.row + 1)"
        cell.labelText.text = note.text
        
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        
        buttonOptions.setImage(UIImage(systemName: "trash"), for: .normal)
        buttonOptions.tintColor = .systemRed
        buttonOptions.menu = UIMenu(title: "Delete Note?",
                                    children: [
                                        UIAction(title: "Delete",
                                                attributes: .destructive,
                                                handler: { _ in
                                                    self.deleteNote(noteId: note._id, at: indexPath)

                                        })
                                    ])
        
        cell.accessoryView = buttonOptions
        cell.selectionStyle = .none
        
        return cell
    }
}

extension NotesViewController: AlertProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
