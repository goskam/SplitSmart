//
//  Owner.swift
//  SplitSmart
//
//  Created by gosia on 06/08/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class GroupMember {
    var id = UUID()
    var name: String
    var balance: Double = 0.0
    @Relationship var group: Group // Optional relationship to Group

    
    init(id: UUID = UUID(), name: String, group: Group) {
        self.id = id
        self.name = name
        self.group = group
    }
}
