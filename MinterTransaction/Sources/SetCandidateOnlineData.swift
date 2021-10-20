//
//  File.swift
//  
//
//  Created by Daniil Dulin on 18.10.2021.
//

import Foundation
import HDWalletKit

public class SetCandidateOnlineData: TransactionData{
    public var publicKey: String
    
    public init(publicKey: String) {
        self.publicKey = publicKey
    }
    
    public func encodeRLP() throws -> Data {
        return try RLP.encode([Data(hex: self.publicKey.stripMinterHexPrefix())] as [Any])
    }
}
