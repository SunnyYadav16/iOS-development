//
//  Contacts.swift
//  WA4_Yadav_1702
//
//  Created by Sunny Yadav on 10/6/25.
//

import Foundation

struct Contacts {
    var name: String?
    var email: String?
    var phoneNumber: String?
    var phoneType: String?
    var address: String?
    var cityState: String?
    var zipCode: Int?
    
    init(name: String? = nil, email: String? = nil, phoneNumber: String? = nil, phoneType: String? = nil, address: String? = nil, cityState: String? = nil, zipCode: Int? = nil) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.phoneType = phoneType
        self.address = address
        self.cityState = cityState
        self.zipCode = zipCode
    }
}
