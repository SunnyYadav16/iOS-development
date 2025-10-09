//
//  MainScreenView.swift
//  WA4_Yadav_1702
//
//  Created by Sunny Yadav on 10/6/25.
//

import UIKit

class MainScreenView: UIView {
    
    var contactListTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUpContactListTableView()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContactListTableView() {
        contactListTableView = UITableView()
        contactListTableView.register(ContactListTableViewCell.self, forCellReuseIdentifier: "contacts")
        contactListTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contactListTableView)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            contactListTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            contactListTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            contactListTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            contactListTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
}
