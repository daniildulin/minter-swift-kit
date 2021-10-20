//
//  RemoveLimitOrderData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class RemoveLimitOrderData: TransactionData{
    public var orderId: Int
    
    public init(orderId: Int) {
        self.orderId = orderId
    }

    public func encodeRLP() throws -> Data {
        return try RLP.encode([orderId] as [Any])
    }
}
