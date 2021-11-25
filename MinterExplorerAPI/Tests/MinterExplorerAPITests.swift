import XCTest
@testable import MinterExplorerAPI

final class MinterExplorerAPITests: XCTestCase {
    
    let api = MinterExplorerAPI(host: "https://explorer-api.taconet.minter.network")
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
        sleep(1)
        XCTAssertEqual(1, 0)
    }
    
    static var allTests = [
        ("testAddress", testAddress),
    ]
}
