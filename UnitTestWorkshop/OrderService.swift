//
//  OrderService.swift
//  CancellationsFeature
//
//  Created by RODRIGO FRANCISCO PABLO on 12/11/24.
//

struct OrderService {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func getDetails(from endpoint: String, parameters: [String: Any], completion: @escaping (Result<OrderDetailsRoot, Error>) -> Void) {
        client.get(endpoint: endpoint, parameters: parameters, completion: completion)
    }
}
