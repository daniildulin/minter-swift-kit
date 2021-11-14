//
//  Balance.swift
//  
//
//  Created by Daniil Dulin on 13.11.2021.
//

import Foundation
import HDWalletKit

public class BalanceCoin{
    public var id: UInt64
    public var symbol: String
    public var pipValue: String
    
    public init(id: UInt64, symbol: String, pipValue: String) {
        self.id = id
        self.symbol = symbol
        self.pipValue = pipValue
    }
    
    public func getValue() throws -> String {
        guard let pip = BInt(self.pipValue, radix: 10),
              let  decimalPip = Decimal(string: pip.description) else {
            throw HDWalletKitError.convertError(.failedToConvert(self.pipValue))
        }
        let result =  decimalPip / pow(Decimal(10), 18)
        return result.description
    }
}

public class Balance {
    public var coins: [BalanceCoin]
    
    public init() {
        self.coins = []
    }
    
    func addCoin(coin: BalanceCoin){
        self.coins.append(coin)
    }
}
