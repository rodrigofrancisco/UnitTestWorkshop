//
//  OrderServiceTests.swift
//  UnitTestWorkshopTests
//
//  Created by RODRIGO FRANCISCO PABLO on 23/01/25.
//

import XCTest
@testable import UnitTestWorkshop

final class OrderServiceTests: XCTestCase {
    func test_getDetails_successfullyGetsData() {
        let client = APIClient(session: .shared)
        let sut = OrderService(client: client)
        
        let expectation = expectation(description: "Expecting orders")
        
        sut.getDetails(from: "https://order-service.com", parameters: [:]) { result in
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
}
