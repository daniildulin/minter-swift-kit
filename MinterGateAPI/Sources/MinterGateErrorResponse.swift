//
//  MinterGateErrorResponse.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//


struct MinterGateErrorResponse: Codable {
    let error: ErrorData
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
}

struct ErrorData: Codable {
    let code, message: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}
