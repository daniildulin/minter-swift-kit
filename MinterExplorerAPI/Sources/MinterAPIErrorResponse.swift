//
//  MinterAPIErrorResponse.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//

import Foundation

public class MinterAPIErrorResponse: Codable {
    let error: MinterAPIErrorData
}

public class MinterAPIErrorData: Codable {
    let code: Int
    let message: String
}
