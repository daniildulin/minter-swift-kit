//
//  EditMultisigData.swift
//  
//
//  Created by Daniil Dulin on 19.10.2021.
//

import Foundation
import HDWalletKit

public class EditMultisigData: TransactionData{
    public var threshold: Int
    public var weights: [Int]
    public var addresses: [String]
    
    public init(threshold: Int, weights: [Int], addresses: [String]) {
        self.threshold = threshold
        self.weights = weights
        self.addresses = addresses
    }
    
    public func encodeRLP() throws -> Data {
        let list = self.addresses.map { (str) -> Data? in
            return Data(hex: str.stripMinterHexPrefix())
        }.filter { (data) -> Bool in
            return data != nil
        } as! [Data]
        let fields = [self.threshold, self.weights, list] as [Any]
        
        return try RLP.encode(fields)
    }
}
