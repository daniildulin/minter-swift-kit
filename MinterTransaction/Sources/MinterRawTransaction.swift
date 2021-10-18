//
// Created by Daniil Dulin on 07.10.2021.
//

import Foundation

public class MinterRawTransaction {
    public var nonce: Int
    public var chainId: Int
    public var gasPrice: Int
    public var gasCoin: Int
    public var type: TransactionType
    public var data: TransactionData
    public var payload: Data
    public var serviceData: Data
    public var signatureType: SignatureType
    public var signatureData: Data?
    
    public init(chainId: Int, nonce: Int, type: TransactionType, gasCoin: Int, gasPrice: Int, signatureType: SignatureType, data: TransactionData, payload: Data = Data.init(), signatureData: Data = Data.init(), serviceData: Data = Data.init()){
        self.chainId = chainId
        self.nonce = nonce
        self.type = type
        self.gasPrice = gasPrice
        self.gasCoin = gasCoin
        self.signatureType = signatureType
        self.data = data
        self.payload = payload
        self.signatureData = signatureData
        self.serviceData = serviceData
    }
}
