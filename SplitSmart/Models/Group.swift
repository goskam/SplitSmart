//
//  Group.swift
//  SplitSmart
//
//  Created by gosia on 07/08/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Group: Identifiable {
    var id = UUID()
    var name: String
    @Relationship var members: [GroupMember]
    @Relationship var expenses: [Expense]
    
    init(id: UUID = UUID(), name: String, members: [GroupMember] = [], expenses: [Expense] = []) {
        self.id = id
        self.name = name
        self.members = members
        self.expenses = expenses
    }
}
