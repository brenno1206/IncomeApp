//
//  TransactionViewModel.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import Foundation
import SwiftUI
import Combine

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    @Published var showAddTransactionView = false
    @Published var transactionToEdit: Transaction? = nil

    @Published var amountToAdd: Double = 0.00
    @Published var selectedTransactionType: TransactionType = .expense
    @Published var transactionTitle: String = ""
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false

}

extension TransactionViewModel {
    func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
    func addTransaction() -> Bool {
        guard transactionTitle.count >= 2 else {
            alertTitle = "Invalid Title"
            alertMessage = "Please enter a valid title for your transaction."
            showAlert = true
            return false}
        
        guard amountToAdd != 0 else {
            alertTitle = "Invalid Amount"
            alertMessage = "Please enter a valid amount for your transaction."
            showAlert = true
            return false}
        
        let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amountToAdd, date: Date())
        
        if let transactionToEdit = transactionToEdit {
            guard let indexOfTransactionToEdit = transactions.firstIndex(of: transactionToEdit) else {
                alertTitle = "Something went wrong"
                alertMessage = "Cannot update the transaction. Please try again."
                showAlert = true
                return false
            }
            transactions[indexOfTransactionToEdit] = transaction
        } else {
            transactions.append(transaction)
        }
        transactionToEdit = nil
        amountToAdd = 0.0
        transactionTitle = ""
        selectedTransactionType = .expense
        return true
    }
}

extension TransactionViewModel {
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var expense : String {
        let sumExpenses = transactions.filter({$0.type == .expense}).reduce(0.00) { $0 + $1.amount }
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "R$ 0.00"
    }
    
    var income : String {
        let sumIncomes = transactions.filter({$0.type == .income}).reduce(0.00) { $0 + $1.amount }
        return numberFormatter.string(from: sumIncomes as NSNumber) ?? "R$ 0.00"
    }
    
    var balance : String {
        let totalBalance = transactions.reduce(0.00) { $1 .type == .expense ? $0 - $1.amount : $0 + $1.amount }
        return numberFormatter.string(from: totalBalance as NSNumber) ?? "R$ 0.00"
    }
}
