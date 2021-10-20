//
//  CreateSwapPoolData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class CreateSwapPoolData: TransactionData{
    public var firstCoinId: Int
    public var secondCoinId: Int
    public var firstCoinVolume: BInt
    public var secondCoinVolume: BInt
    
    public init(firstCoinId: Int, secondCoinId: Int, firstCoinVolume: BInt, secondCoinVolume: BInt) {
        self.firstCoinId = firstCoinId
        self.secondCoinId = secondCoinId
        self.firstCoinVolume = firstCoinVolume
        self.secondCoinVolume = secondCoinVolume
    }
    
    public func encodeRLP() throws -> Data {
        return try RLP.encode([firstCoinId, secondCoinId, firstCoinVolume, secondCoinVolume] as [Any])
    }
}
