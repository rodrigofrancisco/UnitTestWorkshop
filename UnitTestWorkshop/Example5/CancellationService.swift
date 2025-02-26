//
//  CancellationService.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 26/02/25.
//

import Foundation

struct HTTPPostClientImpl {
    func post<T: Encodable, U: Decodable>(
        endpoint: String,
        body: T,
        headers: [String : Any]?,
        completion: @escaping (Result<U, Error>) -> Void) {
        Task {
            do {
                let result = try await URLSession.shared.data(from: URL(string: endpoint)!)
                let decodedResponse = try JSONDecoder().decode(U.self, from: result.0)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(NSError(domain: "Generic error :( plis implement this", code: 0)))
            }
        }
    }
}

struct CanceItemsModel: Encodable {
    struct Item: Encodable {
        let quantity: Int
        let commerceItemID, skuID: String
    }

    let items: [Item]
    let shippingGroupID, orderID, returnReasonID: String
    let cancelItemsCount: Int
}

struct CancellationResponse: Decodable {
    let cancelAuthorizationNo, noPedido, boleta, refundReturnCode: String
    let refundMessage: String
}

struct CancellationService {
    init() {}
    
    func cancelItems(
        using endpoint: String,
        body: CanceItemsModel,
        completion: @escaping (Result<CancellationResponse, Error>) -> Void) {
        HTTPPostClientImpl().post(endpoint: endpoint, body: body, headers: nil, completion: completion)
    }
}
