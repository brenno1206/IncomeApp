//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 15/10/25.
//

import SwiftUI

struct AddTransactionView: View {
    
    @State private var amount = 0.00
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var transactionTitle: String = ""
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @Binding var transactions: [Transaction]
    @Environment(\.dismiss) var dismiss
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Rectangle()
                .fill(.gray)
                .frame(height: 0.6)
                .padding(.horizontal, 30)
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                    
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            Button {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Please enter a valid title for your transaction."
                    showAlert = true
                    return }
                
                guard amount != 0 else {
                    alertTitle = "Invalid Amount"
                    alertMessage = "Please enter a valid amount for your transaction."
                    showAlert = true
                    return }
                
                let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                
                transactions.append(transaction)
                
                dismiss()
            } label: {
                Text("Add Transaction")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.top)
            .padding(.horizontal, 30)

            Spacer()
        }
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("Ok")
            }
        } message: {
            Text(alertMessage)
        }

    }
}

//#Preview {
//    AddTransactionView(transactions: .constant([]))
//}
