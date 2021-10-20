//
//  RemoveLiquidityData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class RemoveLiquidityData: TransactionData{
    public var firstCoinId: Int
    public var secondCoinId: Int
    public var liquidity: BInt
    public var minFirstCoinVolume: BInt
    public var minSecondCoinVolume: BInt
    
    public init(firstCoinId: Int, secondCoinId: Int, liquidity: BInt, minFirstCoinVolume: BInt, minSecondCoinVolume: BInt) {
        self.firstCoinId = firstCoinId
        self.secondCoinId = secondCoinId
        self.liquidity = liquidity
        self.minFirstCoinVolume = minFirstCoinVolume
        self.minSecondCoinVolume = minSecondCoinVolume
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [firstCoinId, secondCoinId, liquidity, minFirstCoinVolume, minSecondCoinVolume] as [Any]
        return try RLP.encode(fields)
    }
}
