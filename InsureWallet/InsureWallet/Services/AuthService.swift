//
//  AuthService.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 19/07/25.
//

import FirebaseAuth
//import FirebaseMessaging

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
    
  /*  func registerDeviceToken(userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
           // Get FCM token
           Messaging.messaging().token { token, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }
               
               guard let deviceToken = token else {
                   print("❌ No FCM token available")
                   return
               }
               
               self.sendTokenToBackend(userId: userId, deviceToken: deviceToken, completion: completion)
           }
       }
    
    private func sendTokenToBackend(userId: String, deviceToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
            guard let url = URL(string: "https://b476095c2475.ngrok-free.app/policy-service/register-device") else {
                print("❌ Invalid URL")
                return
            }

            let payload: [String: Any] = [
                "userId": userId,
                "deviceToken": deviceToken
            ]
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: payload)
            } catch {
                completion(.failure(error))
                return
            }
            
            URLSession.shared.dataTask(with: request) { _, _, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }.resume()
        }*/
}
