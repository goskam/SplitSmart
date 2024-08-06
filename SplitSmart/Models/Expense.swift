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
class Expense: Identifiable, Equatable { //Identifiable, Equatable, Codable
    
    var id = UUID()
    var name: String
    var category: String
    var amount: Double
    var creationDate: Date
    var currencyCode: String //"PLN", "USD", "EUR"
    var groupMember: GroupMember

    init(id: UUID = UUID(), name: String, category: String, amount: Double, creationDate: Date, currencyCode: String, groupMember: GroupMember) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
        self.creationDate = creationDate
        self.currencyCode = currencyCode
        self.groupMember = groupMember
    }
    
    
    func creationDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "d.MM.yy, HH:mm"
        
        return dateFormatter.string(from: creationDate)
    }

    
}
