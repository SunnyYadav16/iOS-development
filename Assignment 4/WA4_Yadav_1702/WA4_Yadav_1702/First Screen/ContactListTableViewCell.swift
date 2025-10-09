//
//  ContactListTableViewCell.swift
//  WA4_Yadav_1702
//
//  Created by Sunny Yadav on 10/6/25.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPhone: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpWrapperCellView()
        setUpLabelName()
        setUpLabelEmail()
        setUpLabelPhone()
        
        initConstraints()
    }
    
    func setUpWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.layer.borderColor = UIColor.gray.cgColor
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.layer.cornerRadius = 8
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setUpLabelName() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 25)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setUpLabelEmail() {
        labelEmail = UILabel()
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelEmail)
    }
    
    func setUpLabelPhone() {
        labelPhone = UILabel()
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelPhone)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 4),
            labelName.heightAnchor.constraint(equalToConstant: 20),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
            labelEmail.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelEmail.heightAnchor.constraint(equalToConstant: 20),
            
            labelPhone.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 4),
            labelPhone.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelPhone.heightAnchor.constraint(equalToConstant: 20),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 76)
        ])
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
