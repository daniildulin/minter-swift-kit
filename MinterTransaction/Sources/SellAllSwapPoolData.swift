//
//  SellAllSwapPoolData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class SellAllSwapPoolData: TransactionData{
    public var coinIds: [Int]
    public var minValueToBuy: BInt
    
    public init(coinIds: [Int], minValueToBuy: BInt) {
        self.coinIds = coinIds
        self.minValueToBuy = minValueToBuy
    }
        
    public func encodeRLP() throws -> Data {
        let fields = [coinIds, minValueToBuy] as [Any]
        return try RLP.encode(fields)
    }
}
