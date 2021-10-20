//
//  SetHaltBlock.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class SetHaltBlockData: TransactionData{
    public var publicKey: String
    public var heigth: Int
    
    public init(publicKey: String, heigth: Int) {
        self.publicKey = publicKey
        self.heigth = heigth
    }
    
    public func encodeRLP() throws -> Data {
        return try RLP.encode([Data(hex: self.publicKey.stripMinterHexPrefix()), heigth] as [Any])
    }
}


