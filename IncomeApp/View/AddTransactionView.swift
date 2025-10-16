//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 15/10/25.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Environment(\.dismiss) var dismiss
   
    @ObservedObject var viewModel: TransactionViewModel
    
    var body: some View {
        VStack {
            TextField("0.00", value: $viewModel.amountToAdd, formatter: viewModel.numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Rectangle()
                .fill(.gray)
                .frame(height: 0.6)
                .padding(.horizontal, 30)
            Picker("Choose Type", selection: $viewModel.selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                    
                }
            }
            TextField("Title", text: $viewModel.transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            Button {
                if viewModel.addTransaction() {
                    dismiss()
                }
            } label: {
                Text(viewModel.transactionToEdit == nil ? "Add Transaction" : "Save Changes")
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
        .onAppear() {
            if let transactionToEdit = viewModel.transactionToEdit {
                viewModel.amountToAdd = transactionToEdit.amount
                viewModel.transactionTitle = transactionToEdit.title
                viewModel.selectedTransactionType = transactionToEdit.type
            }
        }
        .padding(.top)
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button {
                
            } label: {
                Text("Ok")
            }
        } message: {
            Text(viewModel.alertMessage)
        }

    }
}

//#Preview {
//    AddTransactionView(transactions: .constant([]))
//}
