//
//  AddLiquidityData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class AddLiquidityData: TransactionData{
    public var firstCoinId: Int
    public var secondCoinId: Int
    public var firstCoinVolume: BInt
    public var maxSecondCoinVolume: BInt
    
    public init(firstCoinId: Int, secondCoinId: Int, firstCoinVolume: BInt, maxSecondCoinVolume: BInt) {
        self.firstCoinId = firstCoinId
        self.secondCoinId = secondCoinId
        self.firstCoinVolume = firstCoinVolume
        self.maxSecondCoinVolume = maxSecondCoinVolume
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [firstCoinId, secondCoinId, firstCoinVolume, maxSecondCoinVolume] as [Any]
        return try RLP.encode(fields)
    }
}
