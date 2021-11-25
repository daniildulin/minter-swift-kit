//
//  MinterGateNonceResponse.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//

import Foundation

public class MinterGateNonceResponse: Codable {
    let data: MinterGateNonceData
}

public class MinterGateNonceData: Codable {
    let nonce: String
}
