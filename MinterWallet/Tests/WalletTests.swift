import XCTest
import MinterTransaction
import HDWalletKit
@testable import MinterWallet

final class WalletTests: XCTestCase {
    
    let wallet = MinterWallet(mnemonic: "window fun element nominee connect danger belt service race mutual resource zero")
    
    func testAddress() {
        XCTAssertEqual(wallet.getAddress(), "Mxae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e")
    }
    
    func testSignSendTx() {
        //Mtbce7bc8ea59ee792ca2c2943082a11a3eb139b302645762306df2d3d50f6a363
        let txSendData = SendData(to: "Mxae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e", coinId: 0,value: 1)
        let txSend = MinterRawTransaction(
            chainId: 2,
            nonce: 1,
            type:TransactionType.Send,
            gasCoin: 0,
            gasPrice: 1,
            signatureType: SignatureType.single,
            data: txSendData
        )
        
        XCTAssertEqual(
            try! wallet.sign(txSend).toHexString(),
            "f868010201800198d78094ae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e01808001b845f8431ba0fb02fd947f89eebd14af5469c2c6e0527ff0fb7df77fd75700d9619d0d7864e4a07470edaf13f5d6a0a25bfee1958543202da18e1114f188fc2dff3d759270a678"
        )
    }
    
    func testSignSellTx() {
        let txSellData = SellCoinData(sellCoinId: 0, valueToSell: 1, buyCoinId: 1, minValueToBuy: 1)
        let txSell = MinterRawTransaction(
            chainId: 2,
            nonce: 1,
            type:TransactionType.SellCoin,
            gasCoin: 0,
            gasPrice: 1,
            signatureType: SignatureType.single,
            data: txSellData
        )
        
        XCTAssertEqual(
            try! wallet.sign(txSell).toHexString(),
            "f855010201800285c480010101808001b845f8431ba0bf25da1dc8b7d524e4744f7124fe35cb7bfbfeefbe1e936fa56fda17285ff0d8a01e98ff30e761decabedc6090e764fdb8b527629e425263ef42bda8b2d11db477"
        )
    }
    
    func testSignSellAllTx() {
        let txSellData = SellAllCoinData(sellCoinId: 0, buyCoinId: 1, minValueToBuy: 1)
        let txSell = MinterRawTransaction(
            chainId: 2,
            nonce: 1,
            type:TransactionType.SellAllCoin,
            gasCoin: 0,
            gasPrice: 1,
            signatureType: SignatureType.single,
            data: txSellData
        )
        
        XCTAssertEqual(
            try! wallet.sign(txSell).toHexString(),
            "f854010201800384c3800101808001b845f8431ca02250d1a6bc17d551de65c27212ec32018111b9512529c6c82c32c6c2fe5d5fb3a01c57228cca5e87e3a9082017b645965b36bd7905d7c5856a234d1a2ef9de9de4"
        )
    }
    
    func testSignMultisendTx() {
        let txData = MultisendData(list:[
            SendData(to: "Mxae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e", coinId: 0,value: 1),
            SendData(to: "Mx6206b44c51c683064210a09e69a71ab72be14c31", coinId: 0,value: 1)
        ])
        
        let txSell = MinterRawTransaction(
            chainId: 2,
            nonce: 1,
            type:TransactionType.Multisend,
            gasCoin: 0,
            gasPrice: 1,
            signatureType: SignatureType.single,
            data: txData
        )
        
        XCTAssertEqual(
            try! wallet.sign(txSell).toHexString(),
            "f884010201800db4f3f298d78094ae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e0198d780946206b44c51c683064210a09e69a71ab72be14c3101808001b845f8431ca00e14fb1498808003fce8a0954461a0df9bdfb87371d0ab13d37262ddeea53424a016ce7d3ab582a7d653825e0aa198def91df4106c575b6adf5236e15046798c17"
        )
    }
    
    func testSignEditCandidateTx() {
        let txData = EditCandidateData(publicKey: "Mp325580a8baed04899252ae5b5f6167ee34ec0144f3401d88586b350a380bc7d4", rewardAddress: "Mxae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e", ownerAddress: "Mxae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e", controlAddress: "Mxae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e")
        
        let txSell = MinterRawTransaction(
            chainId: 2,
            nonce: 1,
            type:TransactionType.EditCandidate,
            gasCoin: 0,
            gasPrice: 1,
            signatureType: SignatureType.single,
            data: txData
        )
        
        XCTAssertEqual(
            try! wallet.sign(txSell).toHexString(),
            "f8b3010201800eb862f860a0325580a8baed04899252ae5b5f6167ee34ec0144f3401d88586b350a380bc7d494ae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e94ae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e94ae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e808001b845f8431ba00b392d13aa11c6b84301d7c8d3f8e7b209fc573e44e42452e146c1341aebfe9ba0580af2b90b2fe5d0b89512864c9a97d5902c77920dbc9fa04ba8018b90fe2827"
        )
    }
    
    func testSignSetHaltBlockTx() {
        let txData = SetHaltBlockData(publicKey: "Mp325580a8baed04899252ae5b5f6167ee34ec0144f3401d88586b350a380bc7d4", heigth: 123456789)
        
        let txSell = MinterRawTransaction(
            chainId: 2,
            nonce: 1,
            type:TransactionType.SetHaltBlock,
            gasCoin: 0,
            gasPrice: 1,
            signatureType: SignatureType.single,
            data: txData
        )
        
        XCTAssertEqual(
            try! wallet.sign(txSell).toHexString(),
            "f877010201800fa7e6a0325580a8baed04899252ae5b5f6167ee34ec0144f3401d88586b350a380bc7d484075bcd15808001b845f8431ba0c4568115337189c41a54f3f31aa5b881d73ab45b072e0b3b0fef6a7d8eecd3b6a07b53f3d0bc533614fef71b8cc34c32547f49abc6704ade71146df8ea2fde96f0"
        )
    }
    
    func testSignCreateCoinDataTx() {
        let maxSupply = BInt("1000000000000000000000")!
        let txData = CreateCoinData(name: "String", symbol: "tst", initialAmount: 1000000, initialReserve: 1000000, constantReserveRatio: 50, maxSupply: maxSupply)
        
        let txSell = MinterRawTransaction(
            chainId: 2,
            nonce: 1,
            type:TransactionType.CreateCoin,
            gasCoin: 0,
            gasPrice: 1,
            signatureType: SignatureType.single,
            data: txData
        )
        
        XCTAssertEqual(
            try! wallet.sign(txSell).toHexString(),
            "f8760102018005a6e586537472696e678a54535400000000000000830f4240830f424032893635c9adc5dea00000808001b845f8431ba0a5b35dc7ab5d715117afcaa687f8787d6662392449809f8f1be95efb8b6f8193a01ffe080e012b244ea0ad81b01583a334e1b8b1fa42ae871072bef6109172df82"
        )
    }
    
    func testSignCreateTokenDataTx() {
        let maxSupply = BInt("1000000000000000000000")!
        let txData = CreateTokenData(name: "Test", symbol: "Test", initialAmount: 1000, maxSupply: maxSupply, mintable: false, burnable: true)
        
        let txSell = MinterRawTransaction(
            chainId: 2,
            nonce: 1,
            type:TransactionType.CreateToken,
            gasCoin: 0,
            gasPrice: 1,
            signatureType: SignatureType.single,
            data: txData
        )
        
        XCTAssertEqual(
            try! wallet.sign(txSell).toHexString(),
            "f870010201801ea0df84546573748a544553540000000000008203e8893635c9adc5dea000008001808001b845f8431ba0c52ed5760d7f4082db74231e0bd139484a6b968e6b7e119f40e1d29e173ae68fa04f24025ba81dc1e3875037d0f787caf6cd58ce431cfcba726097b2243bcb268c"
        )
    }
    
    static var allTests = [
        ("testAddress", testAddress),
        ("testSignSendTx", testSignSendTx),
        ("testSignSellTx", testSignSellTx),
        ("testSignSellAllTx", testSignSellAllTx),
        ("testSignMultisendTx", testSignMultisendTx),
        ("testSignEditCandidateTx", testSignEditCandidateTx),
        ("testSignSetHaltBlockTx", testSignSetHaltBlockTx),
        ("testSignCreateCoinDataTx", testSignCreateCoinDataTx),
        ("testSignCreateTokenDataTx", testSignCreateTokenDataTx),
    ]
}
