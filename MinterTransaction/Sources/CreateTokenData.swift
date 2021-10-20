//
//  CreateTokenData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class CreateTokenData: TransactionData{
    public var name: String
    public var symbol: String
    public var initialAmount: BInt
    public var maxSupply: BInt
    public var mintable: Bool
    public var burnable: Bool
    
    public init(name: String, symbol: String, initialAmount: BInt, maxSupply: BInt, mintable: Bool, burnable: Bool) {
        self.name = name
        self.symbol = symbol
        self.initialAmount = initialAmount
        self.maxSupply = maxSupply
        self.mintable = mintable
        self.burnable = burnable
    }
    
    public func encodeRLP() throws -> Data {
        let smb = symbol.uppercased().data(using: .utf8)?.setLengthRight(10) ?? Data(repeating: 0, count: 10)
        let mint = mintable ? 1 : 0
        let burn = burnable ? 1 : 0
        let fields = [name, smb, initialAmount, maxSupply, mint, burn] as [Any]
        return try RLP.encode(fields)
    }
}
