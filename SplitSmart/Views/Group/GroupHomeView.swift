//
//  GroupListView.swift
//  SplitSmart
//
//  Created by gosia on 07/08/2024.
//

import SwiftUI
import SwiftData

struct GroupHomeView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var groups: [Group] = []
    @State private var newGroupName: String = ""
    
    @Query var existingGroups: [Group]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(existingGroups) { group in
                    
                    NavigationLink(destination: ExpensesHomeView(group: group)) {
                        
                        HStack {
                            //Text(item.category)
                            Image(systemName: "arrow.up")
                                .padding()
                                .background(Color.orange.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading) {
                                Text(group.name)
                                    .font(.headline)
                                Text(group.name)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                Text(group.name)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                
                            }
                            
                            Spacer()
                            
                            Text(group.name)
                            
                        }
                    }
                }
                .onDelete(perform: deleteGroups)

                HStack {
                       TextField("New Group Name", text: $newGroupName)
                       Button(action: addGroup) {
                           Text("Add Group")
                       }
                   }
            }
            .navigationTitle("Groups")

        }

    }
        
    
    
     func addGroup() {
        let newGroup = Group(name: newGroupName)
        print("New group created with name \(newGroup.name)")
        
        modelContext.insert(newGroup)
        
        newGroupName = ""
    }
    
    private func deleteGroups(at offsets: IndexSet) {
        for offset in offsets {
            let group = existingGroups[offset]
            modelContext.delete(group)
        }
    }
    
}


