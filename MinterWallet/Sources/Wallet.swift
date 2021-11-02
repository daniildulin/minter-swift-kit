//
// Created by Daniil Dulin on 07.10.2021.
//
import Foundation
import HDWalletKit
import MinterTransaction
import GRPC
import NIO
import MinterGRPC

open class MinterWallet {
    var gRPCClient: MinterApiServiceClient?
    var chainId: BInt
    var mnemonic: String
    var privateKey: PrivateKey
    
    private var group: MultiThreadedEventLoopGroup
    
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
        
        self.group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    }
    
    public init(chainId: BInt = 1, nodeHost: String, nodeGRPCPort: Int = 8842) throws {
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
        self.group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        let channel = try? GRPCChannelPool.with(
            target: .hostAndPort(nodeHost, nodeGRPCPort),
            transportSecurity: .plaintext,
            eventLoopGroup: group
        )
        self.gRPCClient = MinterApiServiceClient.init(channel: channel!)
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
        self.group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    }
    
    public init(mnemonic: String, chainId: BInt = 1, nodeHost: String, nodeGRPCPort: Int = 8842){
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
        
        self.group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        let channel = try? GRPCChannelPool.with(
            target: .hostAndPort(nodeHost, nodeGRPCPort),
            transportSecurity: .plaintext,
            eventLoopGroup: group
        )
        
        self.gRPCClient = MinterApiServiceClient.init(channel: channel!)
    }
    
    public func sendTx(_ rawTransaction: MinterRawTransaction) throws -> String{
        if gRPCClient != nil{
            do{
                var hash: String
                let tx = try sign(rawTransaction)
                var sendedTx = MinterSendTransactionRequest()
                sendedTx.tx = "0x"+tx.hex
                let result = try gRPCClient!.sendTransaction(sendedTx).response.wait()
                hash = String(describing: result.hash)
                return hash
            }catch (HDWalletKitError.cryptoError){
                throw MinterWalletError.failedToSign
            }catch{
                throw MinterWalletError.GRPCError
            }
        }
        
        throw MinterWalletError.emptyGRPCClient
    }
    
    public func getNonce() throws -> Int{
        if gRPCClient == nil{
            throw MinterWalletError.emptyGRPCClient
        }
        
        do{
            var request = MinterAddressRequest()
            request.address = getAddress()
            let result = try gRPCClient!.address(request).response.wait()
            return Int(result.transactionCount)+1
        }catch{
            let e = error
            print("\(e)")
            throw MinterWalletError.unknownError
        }
    }
    
    
    public func getPhrase() -> String{
        return self.mnemonic
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
    
    public func close(){
        try! group.syncShutdownGracefully()
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
