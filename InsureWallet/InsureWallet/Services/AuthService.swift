//
//  AuthService.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 19/07/25.
//

import FirebaseAuth

protocol AuthProviding {
    func login(email: String, password: String, completion: @escaping (Result<AppUser, Error>) -> Void)
}
class AuthService: AuthProviding {
    
    static let shared = AuthService()
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<AppUser, Error>) -> Void) {

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let firebaseUser = result?.user {
                let user = AppUser(id: firebaseUser.uid, email: firebaseUser.email)
                completion(.success(user))
            }
        }
    }
}
