//
//  ContentView.swift
//  SplitSmart
//
//  Created by gosia on 05/08/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var expenseItems: [Expense]
    
    // State property to control the presentation of the add expense sheet
    @State private var showingAddExpense = false
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.creationDate),
        SortDescriptor(\Expense.amount)
    ]

    var body: some View {

        NavigationStack {
            
            Text("Expenses")
            
            ExpensesView(sortOrder: sortOrder)
            // Toolbar button to present the add expense sheet
            .toolbar {
                Button("Add expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount)                        ])
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name),
                            ])
                        Text("Sort by Date")
                            .tag([
                                SortDescriptor(\Expense.creationDate),
                                SortDescriptor(\Expense.name),
                            ])
                    }
                    
                }
            }
            // Present the add expense view as a sheet
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView()
            }
        }
    }
    
}

#Preview {
    ContentView()
}
