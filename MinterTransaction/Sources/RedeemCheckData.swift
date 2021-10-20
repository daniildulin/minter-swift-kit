//
//  RedeemCheckData.swift
//  
//
//  Created by Daniil Dulin on 18.10.2021.
//

import Foundation
import HDWalletKit

public class RedeemCheckData: TransactionData{
    public var rawCheck: Data
    public var proof: Data
    
    public init(rawCheck: Data, proof: Data) {
        self.rawCheck = rawCheck
        self.proof = proof
    }
    
    public func encodeRLP() throws -> Data {
        return try RLP.encode([rawCheck, proof] as [Any])
    }
}
