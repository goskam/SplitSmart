//
//  AddOwnerView.swift
//  SplitSmart
//
//  Created by gosia on 06/08/2024.
//

import SwiftUI

struct AddGroupMemberView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let group: Group
    
    @State private var groupMemberName = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Group Member Name", text: $groupMemberName)
            }
            .navigationTitle("Add New Group Member")
            .toolbar {
                Button("Save") {
                    let newGroupMember = GroupMember(name: groupMemberName, group: group)
                    modelContext.insert(newGroupMember)
                   // group.members.append(newGroupMember) // Add member to the group's members list TEST
                    dismiss()
                }
            }
        }    }
}

#Preview {
    AddGroupMemberView(group: Group(name: "Hello"))
}
