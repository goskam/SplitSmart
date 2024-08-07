//
//  AddGroupView.swift
//  SplitSmart
//
//  Created by gosia on 07/08/2024.
//

import SwiftUI
import SwiftData

struct AddGroupView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var newGroupName: String = ""

    var body: some View {

        VStack(alignment: .center) {
               TextField("New Group Name", text: $newGroupName)
                .padding()
                .background(.thinMaterial)
            
               Button(action: addGroup) {
                   Text("Add Group")
               }
               .padding()
           }
        .padding()
        
    }
    
    func addGroup() {
       let newGroup = Group(name: newGroupName)
       print("New group created with name \(newGroup.name)")
       
       modelContext.insert(newGroup)
       
       newGroupName = ""
        
        dismiss()

   }
}

#Preview {
    AddGroupView()
}
