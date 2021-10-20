//
//  SellSwapPoolData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class SellSwapPoolData: TransactionData{
    public var coinIds: [Int]
    public var valueToSell: BInt
    public var minValueToBuy: BInt
    
    public init(coinIds: [Int], valueToSell: BInt, minValueToBuy: BInt) {
        self.coinIds = coinIds
        self.valueToSell = valueToSell
        self.minValueToBuy = minValueToBuy
    }
        
    public func encodeRLP() throws -> Data {
        let fields = [coinIds, valueToSell, minValueToBuy] as [Any]
        return try RLP.encode(fields)
    }
}
