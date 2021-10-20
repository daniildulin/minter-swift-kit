//
//  MintTokenData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class MintTokenData: TransactionData{
    public var coinId: Int
    public var value: BInt
    
    public init(coinId: Int, value: BInt) {
        self.coinId = coinId
        self.value = value
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [coinId, value] as [Any]
        return try RLP.encode(fields)
    }
}
