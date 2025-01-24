//
//  OnboardingManager.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 23/01/25.
//

import Foundation

struct OnboardingModel {
    var versionAndroid: String?
    var versionIOS: String?
    var onboardingFirstTime: [OnboardingInfo]?
    
    struct OnboardingInfo {}
}

protocol OnboardingDependencies {
    var lastShowedVersionForOnboarding: String { get }
    var didShowedFirstInstalledOnboarding: Bool { get }
    var currentAppVersion: String { get }
}

struct OnboardingManager {
    func shouldShowOnboarding(using model: OnboardingModel) -> Bool {
        let lastShowedVersionForOnboarding = UserDefaults.standard.string(forKey: "versionOnboarding") ?? ""
        let didShowedFirstInstalledOnboarding = UserDefaults.standard.bool(forKey: "showFirstTimeOnboard")
        let currentAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        if !didShowedFirstInstalledOnboarding {
            if let onboardingFirstTimeModel = model.onboardingFirstTime, !onboardingFirstTimeModel.isEmpty {
                return true
            }
        } else {
            let iOSVersionInModel = model.versionIOS ?? ""
            if iOSVersionInModel == currentAppVersion && iOSVersionInModel != lastShowedVersionForOnboarding {
                return true
            }
        }
        
        return false
    }
}
