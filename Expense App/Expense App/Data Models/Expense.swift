//
//  Expense.swift
//  Expense App
//
//  Created by Sunny Yadav on 10/2/25.
//

import Foundation
import UIKit

struct Expense{
    var title: String?
    var amount: Double?
    var type: String?
    var image: UIImage?
    
    init(title: String? = nil, amount: Double? = nil, type: String? = nil, image: UIImage) {
        self.title = title
        self.amount = amount
        self.type = type
        self.image = image
    }
    
}
