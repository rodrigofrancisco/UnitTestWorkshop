//
//  WishlistSyncUserCase.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 07/02/25.
//

import Foundation

protocol HTTPClient {
    func get(endpoint: String, completion: (Result<Data, Error>) -> Void)
}

struct WishlistListLibraryItem: Decodable {
    let wishlistId: String
    let content: [WishlistItem]
}

struct WishlistItem: Decodable {
    let id: String
    let productId: String
}

struct WishlistService {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getLists(completion: (Result<[WishlistListLibraryItem], Error>) -> Void) {
        let endpoint = "https://wishlist/lightweight"
        client.get(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                completion(.success( map(data: data)))
            case .failure:
                completion(.success([]))
            }
        }
    }
    
    func map(data: Data) -> [WishlistListLibraryItem] {
        if let jsonData = try? JSONDecoder().decode([WishlistListLibraryItem].self, from: data) {
            return jsonData
        } else {
            return []
        }
    }
}

struct WishlistLightWeightUseCase {
    private let service: WishlistService
    
    init(service: WishlistService) {
        self.service = service
    }
    
    func syncLocalWishlistSnapshot() {
        service.getLists { result in
            switch result {
            case .success(let lists):
                persist(lists)
            case .failure:
                print("Do nothing")
            }
        }
    }
    
    private func persist(_ results: [WishlistListLibraryItem]) {
        print("Saving result on database")
    }
}
