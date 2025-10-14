//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by Brenno Gomes Breda on 14/10/25.
//

import Foundation

struct Transaction : Identifiable {
    let id = UUID()
    let title: String
    let type: TransactionType
    let amount: Double
    let date: Date
}
