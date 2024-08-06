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
    
    @State private var groupMemberName = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Group Member Name", text: $groupMemberName)
            }
            .navigationTitle("Add New Group Member")
            .toolbar {
                Button("Save") {
                    let newGroupMember = GroupMember(name: groupMemberName)
                    modelContext.insert(newGroupMember)
                    dismiss()
                }
            }
        }    }
}

#Preview {
    AddGroupMemberView()
}
