//
// Created by Daniil Dulin on 07.10.2021.
//
import Foundation
import HDWalletKit
import MinterTransaction

open class MinterWallet {
    var nodeURL: URL?
    var chainId: BInt
    var mnemonic: String
    var privateKey: PrivateKey
    
    public init(chainId: BInt = 1){
        self.chainId = chainId
        self.mnemonic = Mnemonic.create()
        let seed = Mnemonic.createSeed(mnemonic:  self.mnemonic)
        let privateKey = PrivateKey(seed: seed, coin: .ethereum)
        let purpose = privateKey.derived(at: .hardened(44))
        // m/44'/60'
        let coinType = purpose.derived(at: .hardened(60))
        // m/44'/60'/0'
        let account = coinType.derived(at: .hardened(0))
        // m/44'/60'/0'/0
        let change = account.derived(at: .notHardened(0))
        // m/44'/60'/0'/0/0
        self.privateKey = change.derived(at: .notHardened(0))
    }
    
    public init(mnemonic: String, chainId: BInt = 1){
        self.chainId = chainId
        self.mnemonic = mnemonic
        let seed = Mnemonic.createSeed(mnemonic:  self.mnemonic)
        let privateKey = PrivateKey(seed: seed, coin: .ethereum)
        let purpose = privateKey.derived(at: .hardened(44))
        // m/44'/60'
        let coinType = purpose.derived(at: .hardened(60))
        // m/44'/60'/0'
        let account = coinType.derived(at: .hardened(0))
        // m/44'/60'/0'/0
        let change = account.derived(at: .notHardened(0))
        // m/44'/60'/0'/0/0
        self.privateKey = change.derived(at: .notHardened(0))
    }
    
    public func getPhrase() -> String{
        return mnemonic
    }
    
    public func getSeed() -> Data{
        return Mnemonic.createSeed(mnemonic: self.mnemonic)
    }
    
    public func getAddress() -> String{
        let ethAdress = self.privateKey.publicKey.address
        var address = "Mx"
        var i = 0
        for c in ethAdress {
            if i > 1{
                address += String(c).lowercased()
            }
            i+=1
        }
        return address
    }
    
    public func sign(_ rawTransaction: MinterRawTransaction) throws -> Data {
        let transactionHash = try hash(rawTransaction: rawTransaction)
        let signature = try self.privateKey.sign(hash: transactionHash)
        return try signTransaction(signature: signature, rawTransaction: rawTransaction)
    }
    
    public func hash(rawTransaction: MinterRawTransaction) throws -> Data {
        return Crypto.sha3keccak256(data: try encode(rawTransaction: rawTransaction))
    }
    
    public func encode(rawTransaction: MinterRawTransaction) throws -> Data {
        
        let  txData = try rawTransaction.data.encodeRLP()
        
        let toEncode: [Any] = [
            rawTransaction.nonce,
            rawTransaction.chainId,
            rawTransaction.gasPrice,
            rawTransaction.gasCoin,
            rawTransaction.type.rawValue,
            txData,
            rawTransaction.payload,
            rawTransaction.serviceData,
            rawTransaction.signatureType.rawValue,
        ]
        
        return try RLP.encode(toEncode)
    }
    
    public func calculateRSV(signature: Data) -> (r: BInt, s: BInt, v: BInt) {
        return (
            r: BInt(signature[..<32].toHexString(), radix: 16)!,
            s: BInt(signature[32..<64].toHexString(), radix: 16)!,
            v: BInt(signature[64]) + ( 27 )
        )
    }
    
    private func signTransaction(signature: Data, rawTransaction: MinterRawTransaction) throws -> Data {
        let (r, s, v) = calculateRSV(signature: signature)
        let txData = try rawTransaction.data.encodeRLP()
        let sData = try SingleSignatureData(v: v, r: r, s: s).encodeRLP()
        
        return try RLP.encode([
            rawTransaction.nonce,
            rawTransaction.chainId,
            rawTransaction.gasPrice,
            rawTransaction.gasCoin,
            rawTransaction.type.rawValue,
            txData,
            rawTransaction.payload,
            rawTransaction.serviceData,
            rawTransaction.signatureType.rawValue,
            sData!
        ])
    }
    
    
}
