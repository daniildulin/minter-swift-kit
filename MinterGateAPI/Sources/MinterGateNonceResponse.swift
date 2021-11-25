//
//  MinterGateNonceResponse.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//

import Foundation

public class MinterGateNonceResponse: Codable {
    public var data: MinterGateNonceData
}

public class MinterGateNonceData: Codable {
    public var nonce: String
}
