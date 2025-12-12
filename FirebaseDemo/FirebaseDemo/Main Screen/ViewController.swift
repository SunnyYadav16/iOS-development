//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by Sunny Yadav on 11/5/25.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    let mainScreen = MainScreenView()
//    var contactsList = [Contact]()
    
//    var handleAuth: AuthStateDidChangeListenerHandle?
//    var currentUser:FirebaseAuth.User?
        
    override func loadView() {
        view = mainScreen
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
//        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
//            if user == nil{
//                //MARK: not signed in...
//                self.currentUser = nil
//                self.mainScreen.labelText.text = "Please sign in to see the notes!"
//                self.mainScreen.floatingButtonAddContact.isEnabled = false
//                self.mainScreen.floatingButtonAddContact.isHidden = true
//                
//                //MARK: Reset tableView...
//                self.contactsList.removeAll()
//                self.mainScreen.tableViewContacts.reloadData()
//                self.setupRightBarButton(isLoggedin: false)
//            }else{
//                //MARK: the user is signed in...
//                self.currentUser = user
//                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
//                self.mainScreen.floatingButtonAddContact.isEnabled = true
//                self.mainScreen.floatingButtonAddContact.isHidden = false
//                self.setupRightBarButton(isLoggedin: true)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Contacts"
        
        //MARK: patching table view delegate and data source...
//        mainScreen.tableViewContacts.delegate = self
//        mainScreen.tableViewContacts.dataSource = self
        
        //MARK: removing the separator line...
        mainScreen.tableViewContacts.separatorStyle = .none
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        view.bringSubviewToFront(mainScreen.floatingButtonAddContact)
    }   
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        Auth.auth().removeStateDidChangeListener(handleAuth!)
//    }

}

