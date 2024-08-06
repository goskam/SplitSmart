//
//  ExpensesView.swift
//  SplitSmart
//
//  Created by gosia on 05/08/2024.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenseItems: [Expense]
    
    var body: some View {
        // List to display existing expense items
        List {
            ForEach(expenseItems) { item in
                HStack{
                    //Text(item.category)
                    EmojiCategoryView(category: item.category)
                        .padding()
                        .background(Color.orange.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.creationDateFormatted())
                            .font(.caption)
                            .foregroundStyle(.gray)


                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: item.currencyCode))

                }
            }
            // Enable swipe-to-delete for the list items
            .onDelete(perform: deleteExpenses)

        }

    }
    
//    init(sortOrder: [SortDescriptor<Expense>]) {
//        _expenseItems = Query(sort: sortOrder)
//    }
    
    init(selectedCategory: String?, sortOrder: [SortDescriptor<Expense>]) {
        if let selectedCategory = selectedCategory, selectedCategory != "All" {
            _expenseItems = Query(filter: #Predicate<Expense> { item in
                item.category == selectedCategory
            }, sort: sortOrder)
        } else {
            _expenseItems = Query(sort: sortOrder)
        }
    }
    
    // Function to delete selected expenses from the list (swipe left)
    private func deleteExpenses(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenseItems[offset]
            modelContext.delete(expense)
        }
    }
    

}

#Preview {
    ExpensesView(selectedCategory: "Travel", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
