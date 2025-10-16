//
//  ContentView.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 14/10/25.
//

import SwiftUI

struct HomeView: View {
        
    @StateObject private var viewModel = TransactionViewModel()
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView(viewModel: viewModel)
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
                        Text(viewModel.balance)
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
                        Text(viewModel.expense)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        Text(viewModel.income)
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
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text("Income & Expenses")
                        .font(.system(size: 35, weight: .bold))
                        .padding(.leading)
                    BalanceView()
                    List {
                        ForEach(viewModel.transactions) { transaction in
                            Button {
                                viewModel.transactionToEdit = transaction
                            } label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            }
                        }
                        .onDelete(perform: viewModel.deleteTransaction)
                    }
                    .scrollContentBackground(.hidden)
                    .padding(.vertical)
                    .padding(.bottom, 30)
                }
                FloatingButton()
            }
            .navigationDestination(item: $viewModel.transactionToEdit, destination: { transaction in
                AddTransactionView(viewModel: viewModel)
            })
            .navigationDestination(isPresented: $viewModel.showAddTransactionView, destination: {
                AddTransactionView(viewModel: viewModel)
            })
        }
    }
}

#Preview {
    HomeView()
}
