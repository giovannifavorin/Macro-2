//
//  ConfessionViewModel.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import SwiftUI
import LocalAuthentication

class AuthManager: ObservableObject {
    
    @Published var isSuccessfullyAuthorized: Bool = false
    
    func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            // Can use Face ID or Touch ID
            let reason = "Please authorize with Face ID, Touch ID or Passcode"
            
            context.evaluatePolicy(.deviceOwnerAuthentication,
                                   localizedReason: reason) { [weak self] success, error in
                
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        // failed auth
                        return
                    }
                    
                    // Success
                    // Advance to next screen by changing the property which is being observed in the Coordinator
                    self?.isSuccessfullyAuthorized = true
                }
            }
        }
    }
}
