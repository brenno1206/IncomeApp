//
//  ContentView.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 14/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type: .income, amount: 120.00, date: Date())
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach(transactions) { transaction in
                    VStack {
                        HStack {
                            Spacer()
                            Text(transaction.displayDate)
                                .font(.system(size: 14))
                            Spacer()
                        }
                        .padding(.vertical, 5)
                        .background(Color.lightGrayShade.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        HStack {
                            Image(systemName: transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward" )
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(transaction.type == .income ? .green : .red)
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(transaction.title)
                                        .font(.system(size: 15, weight: .bold))
                                    Spacer()
                                    Text(transaction.displayAmount)
                                        .font(.system(size: 15, weight: .bold))
                                }
                                Text("Completed")
                                    .font(.system(size: 14))
                            }
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
