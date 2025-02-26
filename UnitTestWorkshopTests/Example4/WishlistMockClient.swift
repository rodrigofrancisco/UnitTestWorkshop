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
        
    }
}
