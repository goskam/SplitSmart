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
    
    @State private var selectedCategory: String? = "Select a category"
    
    let categories = [
        "All",
        "Food",
        "Travel",
        "Rent",
        "Groceries",
        "Gifts",
        "Pets"
    ]

    var body: some View {

        NavigationStack {
            
            VStack {
                Text("Total")
                    .font(.headline)
                
                Text(totalAmount, format: .currency(code: "USD"))
                    .font(.largeTitle)
                    .foregroundColor(.blue)

            }
            
            //List of existing expenses
            ExpensesView(selectedCategory: selectedCategory == "All" ? nil : selectedCategory, sortOrder: sortOrder)


            // Toolbar button to present the add expense sheet
            .toolbar {
                
                //Sort data
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
                
                //Filter by category
                Menu {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category as String?)
                        }
                    }
                } label: {
                    Label("Filter", systemImage: "square.grid.2x2")
                }
                
                //Add expense
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
    
    
    private var totalAmount: Double {
        // Filter expense items based on selected category
        let filteredItems = expenseItems.filter { item in
            if selectedCategory != "All" {
                return item.category == selectedCategory
            }
            return true
        }
        
        // Compute total amount
        return filteredItems.reduce(0) { $0 + $1.amount }
    }
    
}

#Preview {
    ContentView()
}
