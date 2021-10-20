//
//  EditCandidatePublicKeyData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class EditCandidatePublicKeyData: TransactionData{
    public var currentPublicKey: String
    public var newPublicKey: String
    
    public init(publicKey: String, newPublicKey: String) {
        self.currentPublicKey = publicKey
        self.newPublicKey = newPublicKey
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [Data(hex: currentPublicKey.stripMinterHexPrefix()), Data(hex: newPublicKey.stripMinterHexPrefix())] as [Any]
        return try RLP.encode(fields)
    }
}

