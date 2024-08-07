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

    var body: some View {
        GroupHomeView()
    }
            
    
}

#Preview {
    ContentView()
}
