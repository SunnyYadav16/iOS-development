//
//  UserProfileStructure.swift
//  WA7_Yadav_1702
//
//  Created by Sunny Yadav on 10/29/25.
//

import Foundation

struct UserProfile: Codable {
    var _id: String
    var name: String
    var email: String
    
    init(_id: String, name: String, email: String) {
        self._id = _id
        self.name = name
        self.email = email
    }
}
