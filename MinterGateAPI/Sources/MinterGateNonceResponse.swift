//
//  MinterGateNonceResponse.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//

import Foundation

struct MinterGateNonceResponse: Codable {
    let data: MinterGateNonceData
}

struct MinterGateNonceData: Codable {
    let nonce: String
}
