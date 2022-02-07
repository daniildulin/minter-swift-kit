//
//  MinterExplorerCoin.swift
//  
//
//  Created by Daniil Dulin on 16.12.2021.
//

import Foundation

public class MinterExplorerCoinsListResponse: Codable{
    public var data: [MinterExplorerCoin]
}

public class MinterExplorerCoinResponse: Codable{
    public var data: MinterExplorerCoin
}

public class  MinterExplorerCoin: Codable {
    public var id, crr: Int
    public var volume, reserveBalance, maxSupply, name: String
    public var symbol: String
    public var ownerAddress: String?
    public var burnable, mintable: Bool
    public var type: String

    enum CodingKeys: String, CodingKey {
        case id, crr, volume
        case reserveBalance = "reserve_balance"
        case maxSupply = "max_supply"
        case name, symbol
        case ownerAddress = "owner_address"
        case burnable, mintable, type
    }
}
