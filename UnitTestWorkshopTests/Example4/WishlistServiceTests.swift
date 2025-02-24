//
//  WishlistServiceTests.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 24/02/25.
//

import XCTest
@testable import UnitTestWorkshop

extension WishlistListLibraryItem: Encodable {
    enum CodingKeys: String, CodingKey {
        case wishlistId
        case content
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.wishlistId, forKey: .wishlistId)
        try container.encode(self.content, forKey: .content)
    }
}
extension WishlistItem: Encodable {
    enum CodingKeys: String, CodingKey {
        case id
        case productId
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.productId, forKey: .productId)
    }
}

struct WishlistMockClient: HTTPClient {
    func get(endpoint: String, completion: (Result<Data, any Error>) -> Void) {
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
        
        if let data = try? JSONEncoder().encode(lists) {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "Parsing error", code: 1)))
        }
    }
    
    
}

final class WishlistServiceTests: XCTestCase {
    func test_getLists_successOnRightParams() {
        let sut = WishlistService(client: WishlistMockClient())
        
        let expectation = XCTestExpectation(description: "Expecting wishlist lists")
        
        sut.getLists { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.count, 2)
            case .failure(let failure):
                XCTFail("Decoding failed")
            }
            expectation.fulfill()
        }
    }
}
