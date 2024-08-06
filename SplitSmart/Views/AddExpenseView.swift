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

    @Query var groupMembers: [GroupMember]
    
    
    // State properties for the expense fields
    @State private var name = ""
    @State private var category = "Select a category"
    @State private var amount = 0.0
    @State private var currencyCode = "USD" //Default currency
    @State private var selectedGroupMember: GroupMember?

    
    // List of expense categories
    let categories = [
      "Select a category", // Placeholder
      "Food",
      "Travel",
      "Rent",
      "Groceries",
      "Gifts",
      "Pets",
      "Other"
    ]
    
    // List of currency codes
    let currencyCodes = [
        "EUR", "USD", "PLN"
    ]
    
    private var hasValidDetails: Bool {
        !name.isEmpty && amount != 0.0
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                
//                TextField("Amount", value: $amount, format: .currency(code: "USD"))
//                    .keyboardType(.decimalPad)
                
                HStack {
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                    //Text(currencyCode)
                    
                    Picker("Currency", selection: $currencyCode) {
                        ForEach(currencyCodes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Picker("Who paid?", selection: $selectedGroupMember) {
                    Text("Select who paid").tag(GroupMember?.none) // Placeholder for unselected state
                    ForEach(groupMembers) { member in
                        Text(member.name).tag(member as GroupMember?)
                    }
                }
            

            }
            .navigationTitle("Add new expense")
            .toolbar {
                // Save button to add the new expense
                Button("Save") {
                    //below line for debugging purposes
                    //try? modelContext.delete(model: Expense.self)

                    if category == "Select a category" {
                        category = "Other"
                    }
                    
                    // Ensure selectedGroupMember is not nil
                    guard let groupMember = selectedGroupMember else {
                        // Handle the case where no group member is selected
                        // You could show an alert or a message here
                        print("No group member selected")
                        return
                    }
                    
                    let newExpense = Expense(name: name, category: category, amount: amount, creationDate: .now, currencyCode: currencyCode, groupMember: groupMember)
                    
                    print(newExpense.creationDate)
                    print(newExpense.currencyCode)

                    modelContext.insert(newExpense)
                    dismiss()
                }
                .disabled(!hasValidDetails)
            }
            
            


        }
        
    }
}


#Preview {
    AddExpenseView()
}
