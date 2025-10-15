//
//  TransactionView.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 15/10/25.
//

import SwiftUI

struct TransactionView : View {
    let transaction: Transaction
    var body: some View {
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
        .listRowSeparator(.hidden)
    }
}


//#Preview {
//    TransactionView(transaction: Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()))
//}
