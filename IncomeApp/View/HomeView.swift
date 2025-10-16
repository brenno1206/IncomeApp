//
//  ContentView.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 14/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = []
    
    @State private var showAddTransactionView = false
    @State private var transactionToEdit: Transaction?
    
    private var expense : String {
        let sumExpenses = transactions.filter({$0.type == .expense}).reduce(0.00) { $0 + $1.amount }
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .currency
        return numberFormater.string(from: sumExpenses as NSNumber) ?? "R$ 0.00"
    }
    
    private var income : String {
        let sumIncomes = transactions.filter({$0.type == .expense}).reduce(0.00) { $0 + $1.amount }
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .currency
        return numberFormater.string(from: sumIncomes as NSNumber) ?? "R$ 0.00"
    }
    
    private var balance : String {
        let totalBalance = transactions.reduce(0.00) { $1 .type == .expense ? $0 - $1.amount : $0 + $1.amount }
        
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .currency
        return numberFormater.string(from: totalBalance as NSNumber) ?? "R$ 0.00"
    }
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.primaryLightGreen)
            }
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.primaryLightGreen)
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text(balance)
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                .padding(.top)
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        Text(expense)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        Text(income)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    private func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text("Income & Expenses")
                        .font(.system(size: 35, weight: .bold))
                        .padding(.leading)
                    BalanceView()
                    List {
                        ForEach(transactions) { transaction in
                            Button {
                                transactionToEdit = transaction
                            } label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            }
                        }
                        .onDelete(perform: deleteTransaction)
                    }
                    .scrollContentBackground(.hidden)
                    .padding(.vertical)
                    .padding(.bottom, 30)
                }
                FloatingButton()
            }
            .navigationDestination(item: $transactionToEdit, destination: { transaction in
                AddTransactionView(transactions: $transactions, transactionToEdit: transaction)
            })
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                AddTransactionView(transactions: $transactions)
            })
        }
    }
}

#Preview {
    HomeView()
}
