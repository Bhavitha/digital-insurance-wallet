//
//  AuthService.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 19/07/25.
//

import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let firebaseUser = result?.user {
                let user = User(id: firebaseUser.uid, email: firebaseUser.email)
                completion(.success(user))
            }
        }
    }
}
