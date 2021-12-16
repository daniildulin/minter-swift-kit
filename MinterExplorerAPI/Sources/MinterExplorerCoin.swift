//
//  MinterExplorerCoin.swift
//  
//
//  Created by Daniil Dulin on 16.12.2021.
//

import Foundation

public class MinterExplorerCoinResponse: Codable{
    public var data: MinterExplorerCoin
}

public class  MinterExplorerCoin: Codable {
    var id, crr: Int
    var volume, reserveBalance, maxSupply, name: String
    var symbol, ownerAddress: String
    var burnable, mintable: Bool
    var type: String

    enum CodingKeys: String, CodingKey {
        case id, crr, volume
        case reserveBalance = "reserve_balance"
        case maxSupply = "max_supply"
        case name, symbol
        case ownerAddress = "owner_address"
        case burnable, mintable, type
    }
}
