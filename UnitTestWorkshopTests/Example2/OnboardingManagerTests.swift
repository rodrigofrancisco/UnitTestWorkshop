//
//  OnboardingManagerTests.swift
//  UnitTestWorkshopTests
//
//  Created by RODRIGO FRANCISCO PABLO on 23/01/25.
//

import XCTest
@testable import UnitTestWorkshop

struct OnboardingDependenciesMock: OnboardingDependencies {
    let lastShowedVersionForOnboarding: String
    
    let didShowedFirstInstalledOnboarding: Bool
    
    let currentAppVersion: String
    
    init(lastShowedVersionForOnboarding: String, didShowedFirstInstalledOnboarding: Bool, currentAppVersion: String) {
        self.lastShowedVersionForOnboarding = lastShowedVersionForOnboarding
        self.didShowedFirstInstalledOnboarding = didShowedFirstInstalledOnboarding
        self.currentAppVersion = currentAppVersion
    }
}

final class OnboardingManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_shoulwShowOnBoarding_onFirstInstalled_success() throws {
        let sut = OnboardingManager()
        let mock = OnboardingDependenciesMock(lastShowedVersionForOnboarding: "", didShowedFirstInstalledOnboarding: false, currentAppVersion: "")
        
        let result = sut.shouldShowOnboarding(using: .init(), dependencies: mock)
        
        XCTAssertFalse(result)
    }

}
