//
//  BalancesView.swift
//  SplitSmart
//
//  Created by gosia on 06/08/2024.
//

import SwiftUI
import SwiftData

struct BalancesView: View {
    @Query var groupMembers: [GroupMember]
    @Query var expenseItems: [Expense]

    var body: some View {
        List {
            // Section for Balances
            Section(header: Text("Balances")) {
                ForEach(groupMembers) { member in
                    HStack {
                        Text(member.name)
                        Spacer()
                        Text(String(format: "%.2f", member.balance))
                            .foregroundColor(member.balance >= 0 ? .green : .red)
                    }
                }
            }

            // Section for Total Expenses
            Section(header: Text("Total Expenses")) {
                ForEach(groupMembers) { member in
                    HStack {
                        Text(member.name)
                        Spacer()
                        Text(totalExpenses(for: member), format: .currency(code: "USD"))
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle("Group Members")
    }

    private func totalExpenses(for member: GroupMember) -> Double {
        // Only include expenses where the member is the payer
        let expensesPaidByMember = expenseItems.filter { $0.payer.id == member.id }
        return expensesPaidByMember.reduce(0) { $0 + $1.amount }
    }
}

#Preview {
    BalancesView()
}
