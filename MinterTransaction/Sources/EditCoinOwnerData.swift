//
//  EditCoinOwnerData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class EditCoinOwnerData: TransactionData{
    public var symbol: String
    public var address: String
    
    public init(symbol: String, address: String) {
        self.symbol = symbol
        self.address = address
    }
    
    public func encodeRLP() throws -> Data {
        return try RLP.encode([symbol, Data(hex: self.address.stripMinterHexPrefix())] as [Any])
    }
}
