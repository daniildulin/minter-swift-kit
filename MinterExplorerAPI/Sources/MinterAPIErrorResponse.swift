//
//  MinterAPIErrorResponse.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//

import Foundation

struct MinterAPIErrorResponse: Codable {
    let error: MinterAPIErrorData
}

struct MinterAPIErrorData: Codable {
    let code: Int
    let message: String
}
