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
        let lists = [
            WishlistListLibraryItem(wishlistId: "l1", content: [
                .init(id: "w1", productId: "p1"),
                .init(id: "w2", productId: "p2")
            ]),
            WishlistListLibraryItem(wishlistId: "l2", content: [
                .init(id: "w3", productId: "p5"),
                .init(id: "w4", productId: "p6")
            ])
        ]
        
        let sut = WishlistService(client: WishlistMockClient(fake: lists))
        
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
