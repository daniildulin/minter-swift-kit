//
//  Balance.swift
//  
//
//  Created by Daniil Dulin on 13.11.2021.
//

public class BalanceCoin{
    var id: UInt64
    var symbol: String
    var value: String
    
    public init(id: UInt64, symbol: String, value: String) {
        self.id = id
        self.symbol = symbol
        self.value = value
    }
}

public class Balance {
    var coins: [BalanceCoin] = []
    func addCoin(coin: BalanceCoin){
        self.coins.append(coin)
    }
}
