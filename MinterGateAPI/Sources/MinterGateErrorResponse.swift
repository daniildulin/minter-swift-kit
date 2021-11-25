//
//  MinterGateErrorResponse.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//


public class MinterGateErrorResponse: Codable {
    public var error: ErrorData
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
}

public class ErrorData: Codable {
    public var code, message: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}
