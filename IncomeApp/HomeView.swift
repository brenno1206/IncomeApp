//
//  ContentView.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 14/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type: .expense, amount: 120.00, date: Date())
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        Image(systemName: transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward" )
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
