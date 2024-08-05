//
//  SplitSmartApp.swift
//  SplitSmart
//
//  Created by gosia on 05/08/2024.
//

import SwiftUI

@main
struct SplitSmartApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
