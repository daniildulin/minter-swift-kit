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
struct MinterExplorerAddressData: Codable {
    let address: String
    let balances: [BalanceElement]
    let totalBalanceSum, totalBalanceSumUsd, stakeBalanceSum, stakeBalanceSumUsd: String

    enum CodingKeys: String, CodingKey {
        case address, balances
        case totalBalanceSum = "total_balance_sum"
        case totalBalanceSumUsd = "total_balance_sum_usd"
        case stakeBalanceSum = "stake_balance_sum"
        case stakeBalanceSumUsd = "stake_balance_sum_usd"
    }
}

struct BalanceElement: Codable {
    let coin: Coin
    let amount, bipAmount: String

    enum CodingKeys: String, CodingKey {
        case coin, amount
        case bipAmount = "bip_amount"
    }
}

struct Coin: Codable {
    let id: Int
    let type, symbol: String
}
