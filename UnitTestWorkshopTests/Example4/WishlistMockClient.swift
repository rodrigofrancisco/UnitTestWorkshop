//
//  WishlistMockClient.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 24/02/25.
//

import Foundation
@testable import UnitTestWorkshop

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
