//
//  PasswordChangedObserver.swift
//  UnitTestWorkshopTests
//
//  Created by RODRIGO FRANCISCO PABLO on 23/01/25.
//

import Foundation

class PasswordChangedObserver {
    let formatter = ISO8601DateFormatter() // Date example: 2024-11-02T00:00:00Z
    
    func shouldChangePassword(lastUpatedLocalDate lastPassword: String, lastUpatedRemoteDate lastPasswordReset: String?) -> Bool {
        if var lastPasswordUpdate = lastPasswordReset, !lastPasswordUpdate.isEmpty, !lastPassword.isEmpty {
            guard let dateLastPassword = formatter.date(from: lastPassword) else {
                return false
            }
            
            lastPasswordUpdate = lastPasswordUpdate.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
            guard let dateLastPasswordReset = formatter.date(from: lastPasswordUpdate) else {
                return false
            }
            if dateLastPassword < dateLastPasswordReset {
                return true
            }
        } else if let lastPasswordUpdate = lastPasswordReset, !lastPasswordUpdate.isEmpty, lastPassword.isEmpty {
            guard let _ = formatter.date(from: lastPassword) else {
                return false
            }
            return true
        }
        
        return false
    }
}
