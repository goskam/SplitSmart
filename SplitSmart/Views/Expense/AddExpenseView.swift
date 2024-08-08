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
    @State private var splitAmounts: [(member: GroupMember, amount: Double)] = []
    @State private var showSplitDetails = false



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
        !name.isEmpty && amount != 0.0 && payer != nil
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
                
                Section("How to split") {
                    // Save button to add the new expense
                    Button("Split equally") {
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
                        
    //                    guard let payee = payee else {
    //                        print("No payees selected")
    //                        return
    //                    }
                        
                        // Calculate the split amount for each member
                        let memberCount = filteredGroupMembers.count
                        let splitAmount = amount / Double(memberCount)
                        
                        // Prepare the split amounts
                        splitAmounts = filteredGroupMembers.map { member in
                            (member, splitAmount)
                        }
                        
                        showSplitDetails = true
                        

                    }
                    .disabled(!hasValidDetails)
                }
                
                if showSplitDetails {
                    Section("Split details") {
                        ForEach(splitAmounts, id: \.member.id) { entry in
                            HStack {
                                Text(entry.member.name)
                                Spacer()
                                Text(String(format: "%.2f", entry.amount))
                                    .foregroundColor(entry.amount < 0 ? .red : .green)
                            }
                        }
                    }
                }
//                Section("Split equally with") {
//                    Picker("", selection: $payee) {
//                        Text("Select payee").tag(GroupMember?.none) // Placeholder for unselected state
//                        ForEach(filteredGroupMembers) { member in
//                            Text(member.name).tag(member as GroupMember?)
//                        }
//                    }
//                    .frame(maxWidth: 140, alignment: .leading) // Adjust width and alignment
//                }

            

            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button ("Save") {
                    guard let payer = payer else { return }

                    let newExpense = Expense(name: name, category: category, amount: amount, creationDate: .now, currencyCode: currencyCode, payer: payer, group: group)
                    
                    print(newExpense.creationDate)
                    print(newExpense.currencyCode)

                    //group.expenses.append(newExpense)
                    modelContext.insert(newExpense)
                    
                    // Update balances: split amount in half
//                    let splitAmount = amount / 2
//                    payer.balance += splitAmount
//                    payee.balance -= splitAmount
                    
                    //test
                    // Update balances
                    for entry in splitAmounts {
                        if entry.member.id == payer.id {
                            // Payer's balance is credited with the total amount minus their share
                            entry.member.balance += amount - entry.amount
                        } else {
                            // Other members' balances are debited by their share
                            entry.member.balance -= entry.amount
                        }
                    }
                    
                    
                    // Save changes to the model context
                    try? modelContext.save()
                    
                    dismiss()
                }
                .disabled(!hasValidDetails || !showSplitDetails)

            }
        }
    }
    
}


//#Preview {
//    AddExpenseView()
//}
