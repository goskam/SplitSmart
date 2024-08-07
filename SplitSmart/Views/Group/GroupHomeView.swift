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
    @State private var showingAddGroup = false
    
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


            }
            .toolbar {
                Button("Add group", systemImage: "plus") {
                    showingAddGroup.toggle()
                }
            }
            .navigationTitle("Groups")
            // Present the add expense view as a sheet
            .sheet(isPresented: $showingAddGroup) {
                AddGroupView()
            }

        }

    }
        
    
    private func deleteGroups(at offsets: IndexSet) {
        for offset in offsets {
            let group = existingGroups[offset]
            modelContext.delete(group)
        }
    }
    
}


