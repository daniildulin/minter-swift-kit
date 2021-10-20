//
//  SellCoinData.swift
//  
//
//  Created by Daniil Dulin on 18.10.2021.
//

import Foundation
import HDWalletKit

public class SellCoinData: TransactionData{
    public var sellCoinId: Int
    public var valueToSell: BInt
    public var buyCoinId: Int
    public var minValueToBuy: BInt
    
    public init (sellCoinId: Int, valueToSell: BInt, buyCoinId: Int, minValueToBuy: BInt){
        self.sellCoinId =  sellCoinId
        self.valueToSell = valueToSell
        self.buyCoinId = buyCoinId
        self.minValueToBuy = minValueToBuy
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [sellCoinId, valueToSell, buyCoinId, minValueToBuy] as [Any]
        return try RLP.encode(fields)
    }
}

public class SellAllCoinData: TransactionData{
    public var sellCoinId: Int
    public var buyCoinId: Int
    public var minValueToBuy: BInt
    
    public init (sellCoinId: Int, buyCoinId: Int, minValueToBuy: BInt){
        self.sellCoinId =  sellCoinId
        self.buyCoinId = buyCoinId
        self.minValueToBuy = minValueToBuy
    }
    
    public func encodeRLP() throws -> Data {
        let fields = [sellCoinId, buyCoinId, minValueToBuy] as [Any]
        return try RLP.encode(fields)
    }
}
