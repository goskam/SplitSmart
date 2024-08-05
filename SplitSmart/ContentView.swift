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

    var body: some View {

        NavigationStack {
            
            Text("Expenses")
            
            // List to display existing expense items
            List {
                ForEach(expenseItems) { item in
                    HStack{
                        Text(item.name)
                        Text(item.category)
                        Text(String(item.amount))
                    }
                }
                // Enable swipe-to-delete for the list items
                .onDelete(perform: deleteExpenses)

            }
            // Toolbar button to present the add expense sheet
            .toolbar {
                Button("Add expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
            }
            // Present the add expense view as a sheet
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView()
            }
        }
    }
    
    // Function to delete selected expenses from the list (swipe left)
    func deleteExpenses(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenseItems[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ContentView()
}
