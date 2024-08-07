//
//  EmojiCategoryView.swift
//  SplitSmart
//
//  Created by gosia on 05/08/2024.
//

import SwiftUI

struct EmojiCategoryView: View {
    let category: String

    
    var body: some View {
        switch category {
        case "Food":
            Text("🍕")
            
        case "Travel":
            Text("✈️")
            
        case "Rent":
            Text("💰")
            
        case "Gifts":
            Text("🎁")
            
        case "Pets":
            Text("🐶")
            
        case "Groceries":
            Text("🛒")
            
        default:
            Text("🤔")
        }
    }
    
}

#Preview {
    EmojiCategoryView(category: "Food")
}
