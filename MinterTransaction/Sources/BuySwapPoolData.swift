//
//  BuySwapPoolData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class BuySwapPoolData: TransactionData{
    public var coinIds: [Int]
    public var valueToBuy: BInt
    public var maxValueToSell: BInt
    
    public init(coinIds: [Int], valueToBuy: BInt, maxValueToSell: BInt) {
        self.coinIds = coinIds
        self.valueToBuy = valueToBuy
        self.maxValueToSell = maxValueToSell
    }

    public func encodeRLP() throws -> Data {
        let fields = [coinIds, valueToBuy, maxValueToSell] as [Any]
        return try RLP.encode(fields)
    }
}
