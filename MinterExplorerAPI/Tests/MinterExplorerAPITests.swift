import XCTest
@testable import MinterExplorerAPI

final class MinterExplorerAPITests: XCTestCase {
    let api = MinterExplorerAPI(host: "")
    private var tmpStringResult: String = ""
    
    func testAddress()   {
        api.getBalance(address: "Mx54cc7aee0ce4960ebf41480cd80375bdef112922"){ result in
            switch result{
            case .success(let data):
                print ("\(data.totalBalanceSum)")
            case .failure(let error):
                print ("\(error)")
            }
        }
    }
    
    func testCoinInfo()   {
        var id = 0
        api.getCoinInfo(symbol: "HUB"){ result in
            switch result{
            case .success(let data):
                id = data.id
                print ("Coin id: \(data.id)")
            case .failure(let error):
                print ("\(error)")
                
            }
        }
        sleep(1)
        XCTAssertEqual(id, 1902)
    }
    
    static var allTests = [
        ("testAddress", testAddress),
        ("testCoinInfo", testCoinInfo),
    ]
}
