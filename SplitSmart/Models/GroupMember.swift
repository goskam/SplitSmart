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
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
