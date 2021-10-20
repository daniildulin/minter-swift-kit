//
//  PriceVoteData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class PriceVoteData: TransactionData{
    public var price: Int
    
    public init(price: Int) {
        self.price = price
    }

    public func encodeRLP() throws -> Data {
        return try RLP.encode([price] as [Any])
    }
}
