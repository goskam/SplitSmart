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
    @State private var payer: GroupMember?
    //@State private var selectedPayees: Set<GroupMember> = []
    @State private var payee: GroupMember?

    let group: Group
    
    // Filtered group members based on the group
    private var filteredGroupMembers: [GroupMember] {
        groupMembers.filter { $0.group.id == group.id }
    }
    
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
                
                
                Section("Title") {
                    TextField("Expense name", text: $name)
                }
                
                Section("Category") {
                    Picker("", selection: $category) {
                        ForEach(categories, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .frame(maxWidth: 170, alignment: .leading) 
                }

                HStack {
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)

                    Picker("", selection: $currencyCode) {
                        ForEach(currencyCodes, id: \.self) {
                            Text($0)
                        }
                    }
                }

 
                Section("Paid by") {
                    
                    Picker("", selection: $payer) {
                        Text("Select payer").tag(GroupMember?.none) // Placeholder for unselected state
                        ForEach(filteredGroupMembers) { member in
                            Text(member.name).tag(member as GroupMember?)
                        }
                    }
                    .frame(maxWidth: 140, alignment: .leading) // Adjust width and alignment
                    
                }
                
                Section("Split equally with") {
                    Picker("", selection: $payee) {
                        Text("Select payee").tag(GroupMember?.none) // Placeholder for unselected state
                        ForEach(filteredGroupMembers) { member in
                            Text(member.name).tag(member as GroupMember?)
                        }
                    }
                    .frame(maxWidth: 140, alignment: .leading) // Adjust width and alignment
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
                    guard let payer = payer else {
                        // Handle the case where no group member is selected
                        // You could show an alert or a message here
                        print("No group member selected")
                        return
                    }
                    
                    guard let payee = payee else {
                        print("No payees selected")
                        return
                    }
                    
                    let newExpense = Expense(name: name, category: category, amount: amount, creationDate: .now, currencyCode: currencyCode, payer: payer, payee: payee, group: group)
                    
                    print(newExpense.creationDate)
                    print(newExpense.currencyCode)

                    //group.expenses.append(newExpense)
                    modelContext.insert(newExpense)
                    
                    // Update balances: split amount in half
                    let splitAmount = amount / 2
                    payer.balance += splitAmount
                    payee.balance -= splitAmount
                    
                    // Save changes to the model context
                    try? modelContext.save()
                    
                    dismiss()
                }
                .disabled(!hasValidDetails)
            }
        }
    }
    
    //Filter group members for specific froup
//    private var filteredGroupMembers: [GroupMember] {
//        return allGroupMembers.filter { $0.group == group }
//    }
}


//#Preview {
//    AddExpenseView()
//}
