//
//  MinterWalletError.swift
//  
//
//  Created by Daniil Dulin on 26.10.2021.
//

import Foundation

public enum MinterWalletError: Error {
    case emptyGRPCClient
    case GRPCError
    case failedToSign
    case unknownError
}
