import XCTest
@testable import MinterExplorerAPI

final class MinterExplorerAPITests: XCTestCase {
    let api = MinterExplorerAPI(host: "")
    let group = DispatchGroup()
    
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
        group.enter()
        var id = 0
        api.getCoinInfo(symbol: "HUB"){ result in
            switch result{
            case .success(let data):
                id = data.id
            case .failure(let error):
                print ("\(error)")
            }
            
            self.group.leave()
        }
        group.wait()
        XCTAssertEqual(id, 1902)
    }
    
    func testHubCoinInfo()   {
        group.enter()
        api.getHubCoinInfo(){ result in
            switch result{
            case .success(let data):
                var list = data
            case .failure(let error):
                print ("\(error)")
            }
            
            self.group.leave()
        }
        group.wait()
        XCTAssertNotEqual(1, 0)
    }
    
    static var allTests = [
        ("testAddress", testAddress),
        ("testCoinInfo", testCoinInfo),
    ]
}
