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

    }
}
