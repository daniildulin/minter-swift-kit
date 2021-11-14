//
//  Balance.swift
//  
//
//  Created by Daniil Dulin on 13.11.2021.
//

public class BalanceCoin{
    public var id: UInt64
    public var symbol: String
    public var value: String
    
    public init(id: UInt64, symbol: String, value: String) {
        self.id = id
        self.symbol = symbol
        self.value = value
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
