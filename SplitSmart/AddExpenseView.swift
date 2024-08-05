//
//  AddExpenseView.swift
//  SplitSmart
//
//  Created by gosia on 05/08/2024.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    // State properties for the expense fields
    @State private var name = ""
    @State private var category = "Select a category"
    @State private var amount = 0.0
    
    // List of expense categories
    let categories = [
      "Select a category",
      "Food",
      "Travel",
      "Rent",
      "Groceries",
      "Gifts",
      "Pets"
    ]
    
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                // Save button to add the new expense
                Button("Save") {

                    
                    let newExpense = Expense(name: name, category: category, amount: amount, creationDate: .now)
                    
                    print(newExpense.creationDate)
                    
                    modelContext.insert(newExpense)
                    dismiss()
                }
            }
            

        }
        
    }
}


#Preview {
    AddExpenseView()
}
