//
//  MinterGateMinGasResponse.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//

import Foundation

public class MinterGateMinGasResponse: Codable {
    let minGasPrice: String
    
    enum CodingKeys: String, CodingKey {
        case minGasPrice = "min_gas_price"
    }
}
