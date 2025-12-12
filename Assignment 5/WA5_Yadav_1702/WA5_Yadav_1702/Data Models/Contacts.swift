//
//  Contacts.swift
//  WA5_Yadav_1702
//
//  Created by Sunny Yadav on 10/9/25.
//

import Foundation
import UIKit

struct Contacts {
    var name: String?
    var email: String?
    var phoneNumber: String?
    var phoneType: String?
    var address: String?
    var cityState: String?
    var zipCode: Int?
    var profileImage: UIImage?
    
    init(name: String? = nil, email: String? = nil, phoneNumber: String? = nil, phoneType: String? = nil, address: String? = nil, cityState: String? = nil, zipCode: Int? = nil, image: UIImage) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.phoneType = phoneType
        self.address = address
        self.cityState = cityState
        self.zipCode = zipCode
        self.profileImage = image
    }
}
