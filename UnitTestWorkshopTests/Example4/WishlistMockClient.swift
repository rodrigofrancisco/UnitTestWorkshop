//
//  WishlistMockClient.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 24/02/25.
//

import Foundation
@testable import UnitTestWorkshop

struct WishlistMockClient: HTTPClient {
    private let fake: [WishlistListLibraryItem]
    
    init(fake: [WishlistListLibraryItem]) {
        self.fake = fake
    }
    
    func get(endpoint: String, completion: (Result<Data, any Error>) -> Void) {
        if let data = try? JSONEncoder().encode(fake) {
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
