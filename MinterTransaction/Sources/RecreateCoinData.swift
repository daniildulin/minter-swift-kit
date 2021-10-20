//
//  RecreateCoinData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class RecreateCoinData: TransactionData{
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
        let fields = [name, symbol, initialAmount, initialReserve, constantReserveRatio, maxSupply] as [Any]
        return try RLP.encode(fields)
    }
}
