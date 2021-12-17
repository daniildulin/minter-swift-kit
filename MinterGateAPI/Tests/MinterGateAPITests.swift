//
//  MinterGateAPITests.swift
//  
//
//  Created by Daniil Dulin on 25.11.2021.
//

import XCTest
@testable import MinterGateAPI

final class MinterGateAPITests: XCTestCase {
    
    let api = MinterGateAPI(host: "")
    let group = DispatchGroup()
    
    func testGetMinGas()   {
        group.enter()
        api.getMinGas{ result in
            switch result{
            case .success(let data):
                print ("\(data)")
            case .failure(let error):
                print ("\(error)")
            }
            self.group.leave()
        }
        group.wait()
        XCTAssertEqual(1, 0)
    }
    
    func testGetNonce()   {
        group.enter()
        api.getNonce(address: "Mx0e5538dd7f76ba825d1db4a0733b01f3df38c859"){ result in
            switch result{
            case .success(let data):
                print ("\(data)")
            case .failure(let error):
                print ("\(error)")
            }
            self.group.leave()
        }
        group.wait()
        XCTAssertEqual(1, 0)
    }
    
    func testSendTx()   {
        group.enter()
        api.sendTransaction(tx: "0xf8"){ result in
            switch result{
            case .success(let data):
                print ("\(data.tx)")
            case .failure(let error):
                print ("\(error)")
            }
            self.group.leave()
        }
        group.wait()
        XCTAssertEqual(1, 0)
    }
    
    static var allTests = [
        ("testGetMinGas", testGetMinGas),
        ("testGetNonce", testGetNonce),
        ("testSendTx", testSendTx),
    ]
}

