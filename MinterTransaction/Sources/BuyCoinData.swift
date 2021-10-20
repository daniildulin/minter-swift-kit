//
//  BuyCoinData.swift
//  
//
//  Created by Daniil Dulin on 18.10.2021.
//

import Foundation
import HDWalletKit

public class BuyCoinData: TransactionData{
    public var buyCoinId: Int
    public var valueToBuy: BInt
    public var sellCoinId: Int
    public var maxValueToSell: BInt
    
    public init (buyCoinId: Int, valueToBuy: BInt, sellCoinId: Int, maxValueToSell: BInt){
        self.buyCoinId = buyCoinId
        self.valueToBuy = valueToBuy
        self.sellCoinId =  sellCoinId
        self.maxValueToSell = maxValueToSell
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [buyCoinId, valueToBuy, sellCoinId, maxValueToSell] as [Any]
        return try RLP.encode(fields)
    }
}
