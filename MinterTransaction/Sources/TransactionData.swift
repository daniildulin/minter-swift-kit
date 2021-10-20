//
//  TransactionData.swift
//  
//
//  Created by Daniil Dulin on 14.10.2021.
//

import Foundation

public protocol TransactionData{
    func encodeRLP() throws -> Data
}
