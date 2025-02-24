//
//  UnitTestWorkshopTests.swift
//  UnitTestWorkshopTests
//
//  Created by RODRIGO FRANCISCO PABLO on 23/01/25.
//

import XCTest
@testable import UnitTestWorkshop

final class PasswordChangedObserverTests: XCTestCase {
    func test_shouldChangePassword_withSameDates_shouldFail() {
        // Given
        let sut = PasswordChangedObserver()
        // When
        let result = sut.shouldChangePassword(lastUpatedLocalDate: "", lastUpatedRemoteDate: "")
        // Then
        XCTAssertFalse(result)
    }
}
