//
//  Expense.swift
//  Expense App
//
//  Created by Sunny Yadav on 10/2/25.
//

import Foundation

struct Expense{
    var title: String?
    var amount: Double?
    var type: String?
    
    init(title: String? = nil, amount: Double? = nil, type: String? = nil) {
        self.title = title
        self.amount = amount
        self.type = type
    }
    
}
