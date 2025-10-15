//
//  TransactionTypeModel.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 14/10/25.
//

import Foundation

enum TransactionType: String, CaseIterable, Identifiable {
    case income, expense
    
    var id: Self { self }
    
    var title : String{
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
