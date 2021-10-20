//
//  VoteUpdateData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class VoteUpdateData: TransactionData{
    public var version: String
    public var publicKey: String
    public var heigth: Int

    public init(version: String, publicKey: String, heigth: Int) {
        self.version = version
        self.publicKey = publicKey
        self.heigth = heigth
    }

    public func encodeRLP() throws -> Data {
        return try RLP.encode([version, Data(hex: self.publicKey.stripMinterHexPrefix()), heigth] as [Any])
    }
}
