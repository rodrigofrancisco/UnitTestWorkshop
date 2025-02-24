//
//  WishlistServiceTests.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 24/02/25.
//

import XCTest
@testable import UnitTestWorkshop

final class WishlistServiceTests: XCTestCase {
    func test_getLists_successOnRightParams() {
        let sut = WishlistService(client: WishlistMockClient())
        
        let expectation = expectation(description: "Expecting wishlist lists")
        
        sut.getLists { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.count, 2)
            case .failure:
                XCTFail("Decoding failed")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
