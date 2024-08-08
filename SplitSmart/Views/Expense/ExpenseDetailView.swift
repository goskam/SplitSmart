//
//  ExpenseDetailView.swift
//  SplitSmart
//
//  Created by gosia on 06/08/2024.
//

import SwiftUI
import SwiftData

struct ExpenseDetailView: View {
    @Environment(\.modelContext) var modelContext
    var expense: Expense

    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                
                HStack {
                    EmojiCategoryView(category: expense.category)
                        .padding()
                        .background(Color.orange.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        Text(expense.amount, format: .currency(code: expense.currencyCode))
                            .font(.title2)
                            .bold()
                        Text(expense.creationDateFormatted())
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }

                }
                
                VStack(alignment: .leading) {
                    Text("\(expense.payer.name) paid \(expense.amount, format: .currency(code: expense.currencyCode))")
                    //Text("\(expense.payee.name) owes: \(expense.payer.name) \(expense.payee.balance)")
                    
                }
                .padding()
                
                VStack(alignment: .leading) {
                    
                    Text("Current balance of payer \(expense.payer.name) is: \(expense.payer.balance)")
                    //Text("Current balance of payee \(expense.payee.name) is: \(expense.payee.balance)")
                }
                .padding()

            }
            
            Spacer()







        }
        .padding()
        .navigationTitle("Expense Details")
    }
}

//#Preview {
//    ExpenseDetailView(expense: Expense(name: "Test Expense", category: "Food", amount: 50.0, creationDate: .now, currencyCode: "USD", payer: GroupMember(name: "Gosia"), payee: GroupMember(name: "David")))
//}
