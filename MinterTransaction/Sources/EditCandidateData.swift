//
//  EditCandidateData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class EditCandidateData: TransactionData{
    public var publicKey: String
    public var rewardAddress: String
    public var ownerAddress: String
    public var controlAddress: String
    
    public init(publicKey: String, rewardAddress: String, ownerAddress: String, controlAddress: String) {
        self.publicKey = publicKey
        self.rewardAddress = rewardAddress
        self.ownerAddress = ownerAddress
        self.controlAddress = controlAddress
    }
    
    public func encodeRLP() throws -> Data {
        return try RLP.encode([Data(hex: self.publicKey.stripMinterHexPrefix()), Data(hex: self.rewardAddress.stripMinterHexPrefix()), Data(hex: self.ownerAddress.stripMinterHexPrefix()), Data(hex: self.controlAddress.stripMinterHexPrefix())] as [Any])
    }
}
