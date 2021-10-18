//
//  SignatureData.swift
//  
//
//  Created by Daniil Dulin on 16.10.2021.
//
import HDWalletKit
import Foundation

protocol SignatureData {
    func encodeRLP() throws -> Data?
}

public class SingleSignatureData: SignatureData{
    var v: BInt
    var s: BInt
    var r: BInt
    
    public init(v: BInt = BInt(1), r: BInt = BInt(0), s: BInt = BInt(0)) {
        self.v = v
        self.r = r
        self.s = s
    }
    
    public func encodeRLP() throws -> Data? {
        let fields = [self.v, self.r, self.s]
        return try RLP.encode(fields)
    }
}


public class MultiSignatureData: SignatureData {
    var multisigAddress: String
    var signatures = [(v: Data, r: Data, s: Data)]()

    public init(multisigAddress: String, signatures: [(v: Data, r: Data, s: Data)]) {
        self.multisigAddress = multisigAddress
        self.signatures = signatures
    }

    public func encodeRLP() throws -> Data? {
        let address = Data(Array<UInt8>(hex: multisigAddress.lowercased().stripMinterHexPrefix()))
        return try RLP.encode([address, signatures.map { (data) -> [Data] in
            return [data.v, data.r, data.s]
        }])
    }
}
