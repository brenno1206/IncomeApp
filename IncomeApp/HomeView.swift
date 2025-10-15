//
//  ContentView.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 14/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "UVV", type: .income, amount: 400.00, date: Date()),
        Transaction(title: "Crunchyroll", type: .expense, amount: 15.00, date: Date())
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach(transactions) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    HomeView()
}
