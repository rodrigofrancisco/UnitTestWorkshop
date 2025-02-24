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

struct OnboardingDependenciesImpl: OnboardingDependencies {
    var lastShowedVersionForOnboarding: String {
        UserDefaults.standard.string(forKey: "versionOnboarding") ?? ""
    }
    
    var didShowedFirstInstalledOnboarding: Bool {
        UserDefaults.standard.bool(forKey: "showFirstTimeOnboard")
    }
    
    var currentAppVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

struct OnboardingManager {
    func shouldShowOnboarding(using model: OnboardingModel, dependencies: OnboardingDependencies = OnboardingDependenciesImpl()) -> Bool {
        let lastShowedVersionForOnboarding = dependencies.lastShowedVersionForOnboarding
        let didShowedFirstInstalledOnboarding = dependencies.didShowedFirstInstalledOnboarding
        let currentAppVersion = dependencies.currentAppVersion
        
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

//let lastShowedVersionForOnboarding = UserDefaults.standard.string(forKey: "versionOnboarding") ?? ""
//let didShowedFirstInstalledOnboarding = UserDefaults.standard.bool(forKey: "showFirstTimeOnboard")
//let currentAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
