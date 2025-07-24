//
//  LoginViewModel.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 16/07/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private let authService: AuthProviding
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    
    init(authService: AuthProviding = AuthService.shared) {
        self.authService = authService
    }

    func login() {
        errorMessage = nil
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty"
            return
        }
        authService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(_):
                    self?.isLoading = true
                    self?.isLoggedIn = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
