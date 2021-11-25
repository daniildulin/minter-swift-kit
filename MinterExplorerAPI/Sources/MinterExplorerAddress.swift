//
//  MinterExplorerAddress.swift
//  
//
//  Created by Daniil Dulin on 15.11.2021.
//

import Foundation

// MARK: - Balance
struct MinterExplorerAddressResponse: Codable {
    let data: MinterExplorerAddressData
    let latestBlockTime: String

    enum CodingKeys: String, CodingKey {
        case data
        case latestBlockTime = "latest_block_time"
    }
}

// MARK: - MinterExplorerAddressData
public class MinterExplorerAddressData: Codable {
    public var address: String
    public var balances: [BalanceElement]
    public var totalBalanceSum, totalBalanceSumUsd, stakeBalanceSum, stakeBalanceSumUsd: String

    enum CodingKeys: String, CodingKey {
        case address, balances
        case totalBalanceSum = "total_balance_sum"
        case totalBalanceSumUsd = "total_balance_sum_usd"
        case stakeBalanceSum = "stake_balance_sum"
        case stakeBalanceSumUsd = "stake_balance_sum_usd"
    }
}

public class BalanceElement: Codable {
    public var coin: Coin
    public var amount, bipAmount: String

    enum CodingKeys: String, CodingKey {
        case coin, amount
        case bipAmount = "bip_amount"
    }
}

public class Coin: Codable {
    public var id: Int
    public var type, symbol: String
}
