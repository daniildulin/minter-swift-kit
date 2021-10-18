import XCTest
import MinterTransaction
@testable import MinterWallet

final class WalletTests: XCTestCase {
    
    let wallet = MinterWallet(mnemonic: "window fun element nominee connect danger belt service race mutual resource zero")
    
    func testAddress() {
        XCTAssertEqual(wallet.getAddress(), "Mxae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e")
    }
    
    func testSign() {
        
        let txData = SendData(to: "Mxae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e", coinId: 0,value: 1)
        
        let tx = MinterRawTransaction(
            chainId: 2,
            nonce: 1,
            type:TransactionType.Send,
            gasCoin: 0,
            gasPrice: 1,
            signatureType: SignatureType.single,
            data: txData
        )
        
        XCTAssertEqual(
            try! wallet.sign(tx).toHexString(),
            "f868010201800198d78094ae1cb84fe2006ecbd8999d1db2c1e6a6b1362d5e01808001b845f8431ba0fb02fd947f89eebd14af5469c2c6e0527ff0fb7df77fd75700d9619d0d7864e4a07470edaf13f5d6a0a25bfee1958543202da18e1114f188fc2dff3d759270a678"
        )
    }
    
    static var allTests = [
        ("testAddress", testAddress),
        ("testSign", testSign),
    ]
}
