//
//  UnbondData.swift
//  
//
//  Created by Daniil Dulin on 18.10.2021.
//

import Foundation
import HDWalletKit

public class UnbondData: TransactionData{
    public var publicKey: String
    public var coinId: Int
    public var value: BInt
    
    public init(publicKey: String, coinId: Int, value: BInt) {
        self.publicKey = publicKey
        self.coinId = coinId
        self.value = value
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [Data(hex: publicKey.stripMinterHexPrefix()), coinId, value] as [Any]
        return try RLP.encode(fields)
    }
}


