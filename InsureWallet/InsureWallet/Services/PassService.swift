//
//  WalletManager.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import Foundation
import PassKit

class PassService {
    static let shared = PassService()

    func canAddPasses() -> Bool {
        PKAddPassesViewController.canAddPasses()
    }

    // load pass from bundle
    func loadPass() -> PKPass? {
        guard let url = Bundle.main.url(forResource: "pass", withExtension: "pkpass") else {
            print("❌ pass.pkpass file not found in bundle")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let pass = try PKPass(data: data)
            return pass
        } catch {
            print("❌ Failed to load PKPass: \(error)")
            return nil
        }
    }
    
    //load pass from server
    func requestPass(from urlString: String, with parameters: [String: Any], completion: @escaping (PKPass?) -> Void) {
        guard let request = createRequest(urlString: urlString, parameters: parameters) else {
                  print("Failed to create URLRequest")
                  completion(nil)
                  return
              }

           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Network error: \(error.localizedDescription)")
                   completion(nil)
                   return
               }

               guard let data = data else {
                   print("No data in response")
                   completion(nil)
                   return
               }

               do {
                   let pass = try PKPass(data: data)
                   completion(pass)
               } catch {
                   print("Failed to create PKPass from response: \(error)")
                   completion(nil)
               }
           }

           task.resume()
       }
    
    private func createRequest(urlString: String, parameters: [String: Any]) -> URLRequest? {
           guard let url = URL(string: urlString) else {
               print("Invalid URL: \(urlString)")
               return nil
           }

           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           do {
               let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
               request.httpBody = jsonData
           } catch {
               print("Failed to serialize JSON: \(error.localizedDescription)")
               return nil
           }

           return request
       }

    func presentWalletPass() {
        guard let pass = loadPass(),
              let addVC = PKAddPassesViewController(pass: pass) else {
            print("❌ Wallet VC not available")
            return
        }

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first,
           let rootVC = window.rootViewController {
            DispatchQueue.main.async {
                rootVC.present(addVC, animated: true)
            }
        }
    }
    
    func presentWalletPass(from urlString: String, with parameters: [String: Any]) {
           requestPass(from: urlString, with: parameters) { pass in
               guard let pass = pass,
                     let addVC = PKAddPassesViewController(pass: pass) else {
                   print("❌ Could not present Wallet VC")
                   return
               }

               DispatchQueue.main.async {
                   if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let window = scene.windows.first,
                      let rootVC = window.rootViewController {
                       rootVC.present(addVC, animated: true)
                   }
               }
           }
       }
}
