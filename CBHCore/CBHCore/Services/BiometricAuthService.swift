//
//  BiometricAuthService.swift
//  CBHCards
//
//  Created by Serhii Horielov on 19.09.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import Foundation
import LocalAuthentication

enum BiometryType {
    case none
    case touchID
    case faceID

    var description: String {
        switch self {
        case .touchID:
            return "Touch ID"
        case .faceID:
            return "Face ID"
        case .none:
            return ""
        }
    }
}

typealias BiometricAuthResultCompletion = (BiometricAuthResult) -> Void

enum BiometricAuthResult {
    case success
    case cancelled
    case error(description: String)
}

protocol BiometricAuthService {
    var availableBiometryType: BiometryType { get }
    func authenticate(reason: String, completion: @escaping BiometricAuthResultCompletion)
}

class BiometricAuthServiceImpl: BiometricAuthService {
    
    // MARK: - Pivate Variables
    
    private var authentificationContext = LAContext()
    private let laPolicy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    
    // MARK: - Public
    
    var availableBiometryType: BiometryType {
        let _ = authentificationContext.canEvaluatePolicy(laPolicy, error: nil)
        let biometryType = authentificationContext.biometryType
        switch biometryType {
        case .faceID:
            return .faceID
        case .touchID:
            return .touchID
        default:
            return .none
        }
    }
    
    func authenticate(reason: String, completion: @escaping BiometricAuthResultCompletion) {
        
        refreshContext()
        
        let defaultAuthErrorMessage = "Authentication Failed"
        var authError: NSError?
        
        if authentificationContext.canEvaluatePolicy(laPolicy, error: &authError) {
            authentificationContext.evaluatePolicy(laPolicy, localizedReason: reason) { success, evaluateError in
                if success {
                    completion(.success)
                    return
                }
                
                var errorMessage = defaultAuthErrorMessage
                if let evaluateError = evaluateError as? LAError {
                    switch evaluateError.code {
                    case .appCancel, .systemCancel, .userFallback, .userCancel:
                        return completion(.cancelled)
                    default:
                        errorMessage = evaluateError.localizedDescription
                    }
                }
                completion(.error(description: errorMessage))
            }
        } else {
            var errorMessage = defaultAuthErrorMessage
            if let authError = authError {
                errorMessage = authError.localizedDescription
            }
            completion(.error(description: errorMessage))
        }
    }
}

private extension BiometricAuthServiceImpl {
    func refreshContext() {
        authentificationContext = LAContext()
    }
}
