//
//  EditCandidateCommissionData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class EditCandidateCommissionData: TransactionData{
    public var publicKey: String
    public var commission: Int
    
    public init(publicKey: String, commission: Int) {
        self.publicKey = publicKey
        self.commission = commission
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [Data(hex: publicKey.stripMinterHexPrefix()), commission] as [Any]
        return try RLP.encode(fields)
    }
}
