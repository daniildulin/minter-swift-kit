//
//  MinterAPIErrorResponse.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//

import Foundation

public class MinterAPIErrorResponse: Codable {
    public var error: MinterAPIErrorData
}

public class MinterAPIErrorData: Codable {
    public var code: Int
    public var message: String
}
