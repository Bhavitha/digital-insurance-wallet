//
//  MockAuthService.swift
//  InsureWalletTests
//
//  Created by Bhavitha Gottimukkula on 24/07/25.
//

import XCTest
@testable import InsureWallet

class MockAuthService: AuthProviding {
    var shouldSucceed = true
    var loginCalled = false
    
    func login(email: String, password: String, completion: @escaping (Result<AppUser, Error>) -> Void) {
        if shouldSucceed {
            completion(.success(AppUser(id: "mock-uid", email: "mock@example.com")))
        } else {
            completion(.failure(NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])))
        }
    }
}
