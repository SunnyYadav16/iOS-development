//
//  Contact.swift
//  Working with APIs
//
//  Created by Sunny Yadav on 10/22/25.
//

import Foundation

struct Contact{
    var name:String
    var email:String
    var phone: Int
    
    init(name: String, email: String, phone: Int) {
        self.name = name
        self.email = email
        self.phone = phone
    }
}
