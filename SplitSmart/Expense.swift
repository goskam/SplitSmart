//
//  Expense.swift
//  SplitSmart
//
//  Created by gosia on 05/08/2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Expense: Identifiable, Equatable { //Codable
    
    var id = UUID()
    var name: String
    var category: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, category: String, amount: Double) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
    }
    
}
