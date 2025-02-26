//
//  CancellationService.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 26/02/25.
//

protocol HTTPPostClient {
    func post<T: Encodable, U: Decodable>(endpoint: String, body: T, headers: [String : Any]?, completion: @escaping (Result<U, Error>) -> Void)
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
    private let client: HTTPPostClient
    
    
    init(client: HTTPPostClient) {
        self.client = client
    }
    
    func cancelItems(using endpoint: String, body: CanceItemsModel, completion: @escaping (Result<CancellationResponse, Error>) -> Void) {
        client.post(endpoint: endpoint, body: body, headers: nil, completion: completion)
    }
}
