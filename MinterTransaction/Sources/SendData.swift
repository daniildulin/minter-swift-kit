//
//  SendData.swift
//  
//
//  Created by Daniil Dulin on 18.10.2021.
//

import Foundation
import HDWalletKit

public class SendData: TransactionData{
    
    public var to: String
    public var coinId: Int
    public var value: BInt
    
    public init (to: String, coinId: Int, value: BInt){
        self.to =  to
        self.coinId = coinId
        self.value = value
    }
    
    public func encodeRLP() throws -> Data {
        let dataArray = Array<UInt8>(hex: self.to.lowercased().stripMinterHexPrefix())
        let toData = Data(dataArray)
        let fields = [coinId, toData, value] as [Any]
        return try RLP.encode(fields)
    }
}
