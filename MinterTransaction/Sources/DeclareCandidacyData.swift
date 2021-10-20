//
//  DeclareCandidacyData.swift
//  
//
//  Created by Daniil Dulin on 18.10.2021.
//

import Foundation
import HDWalletKit

public class DeclareCandidacyData: TransactionData{
    public var address: String
    public var publicKey: String
    public var commission: Int
    public var coinId: Int
    public var stake: BInt
    
    public init(address: String, publicKey: String, commission: Int, coinId: Int, stake: BInt) {
        self.address = address
        self.publicKey = publicKey
        self.commission = commission
        self.coinId = coinId
        self.stake = stake
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [Data(hex: address.stripMinterHexPrefix()), Data(hex: publicKey.stripMinterHexPrefix()), commission, coinId, stake] as [Any]
        return try RLP.encode(fields)
    }
}
