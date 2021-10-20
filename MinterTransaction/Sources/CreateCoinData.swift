//
//  CreateCoinData.swift
//  
//
//  Created by Daniil Dulin on 18.10.2021.
//

import Foundation
import HDWalletKit

public class CreateCoinData: TransactionData{
    public var name: String
    public var symbol: String
    public var initialAmount: BInt
    public var initialReserve: BInt
    public var constantReserveRatio: Int
    public var maxSupply: BInt
    
    public init (name: String, symbol: String, initialAmount: BInt, initialReserve: BInt, constantReserveRatio: Int, maxSupply: BInt){
        self.name = name
        self.symbol = symbol
        self.initialAmount =  initialAmount
        self.initialReserve = initialReserve
        self.constantReserveRatio = constantReserveRatio
        self.maxSupply = maxSupply
    }
    
    public func encodeRLP() throws -> Data {
        let smb = symbol.uppercased().data(using: .utf8)?.setLengthRight(10) ?? Data(repeating: 0, count: 10)
        let fields = [name, smb, initialAmount, initialReserve, constantReserveRatio, maxSupply] as [Any]
        return try RLP.encode(fields)
    }
}
