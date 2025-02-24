//
//  OrderServiceTests.swift
//  UnitTestWorkshopTests
//
//  Created by RODRIGO FRANCISCO PABLO on 23/01/25.
//

import XCTest
@testable import UnitTestWorkshop

final class OrderServiceTests: XCTestCase {
    override func setUp() {
        URLProtocolStub.startIncerceptingRequest()
    }
    
    override func tearDown() {
        URLProtocolStub.stopIncerceptingRequest()
    }
    
    func test_getDetails_successfullyGetsData() {
        let client = APIClient(session: .shared)
        let sut = OrderService(client: client)
        
        let endpoint = "https://order-service.com/details"
        
        URLProtocolStub.stub(
            data: try! JSONEncoder().encode(fakeResponse),
            response: HTTPURLResponse(url: URL(string: endpoint)!, statusCode: 200, httpVersion: nil, headerFields: nil),
            error: nil
        )
        
        let expectation = expectation(description: "Expecting orders")
        sut.getDetails(from: endpoint, parameters: [:]) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.status.code, 0)
            case .failure:
                XCTFail("Did not retrieve data")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    var fakeResponse: OrderDetailsRootFake {
        return OrderDetailsRootFake(orderNumber: "01", status: .ok)
    }
}

struct OrderDetailsRootFake: Codable {
    let orderNumber: String?
    let status: ServiceStatusFake
}

public struct ServiceStatusFake: Codable {
    let status: String
    let statusCode: Int
    let code: Int?
    let errorDescription: String?
    let datailedErrorDescription: String?
    let successMessage: String?
    
    static let ok = ServiceStatusFake(
        status: "OK",
        statusCode: 0,
        code: 0,
        errorDescription: nil,
        datailedErrorDescription: nil,
        successMessage: "Good to go"
    )
}
