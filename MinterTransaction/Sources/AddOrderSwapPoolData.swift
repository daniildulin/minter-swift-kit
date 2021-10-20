//
//  AddOrderSwapPoolData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class AddOrderSwapPoolData: TransactionData{
    public var sellCoinId: Int
    public var valueToSell: BInt
    public var buyCoinId: Int
    public var valueToBuy: BInt
    
    public init(sellCoinId: Int, valueToSell: BInt, buyCoinId: Int, valueToBuy: BInt) {
        self.sellCoinId = sellCoinId
        self.valueToSell = valueToSell
        self.buyCoinId = buyCoinId
        self.valueToBuy = valueToBuy
    }

    public func encodeRLP() throws -> Data {
        return try RLP.encode([sellCoinId, valueToSell, buyCoinId, valueToBuy] as [Any])
    }
}
