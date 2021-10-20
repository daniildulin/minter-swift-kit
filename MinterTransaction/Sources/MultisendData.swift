//
//  MultisendData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class MultisendData: TransactionData{
    public var list: [SendData]
    
    public init() {
        self.list = []
    }
    
    public init(list: [SendData]) {
        self.list = list
    }
    
    public func addRecepien(data: SendData){
        list.append(data)
    }
    
    public func encodeRLP() throws -> Data {
        var receivers: [Data] = []
        for sendData in list {
            let d = try sendData.encodeRLP()
            receivers.append(d)
        }
        let fields = [receivers] as [Any]
        return try RLP.encode(fields)
    }
}

