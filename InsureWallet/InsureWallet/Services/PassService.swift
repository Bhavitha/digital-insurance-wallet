//
//  WalletManager.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import Foundation
import PassKit

class PassService: NSObject {
    static let shared = PassService()
    var pkPass: PKPass?

    func canAddPasses() -> Bool {
        PKAddPassesViewController.canAddPasses()
    }

    // load pass from bundle
//    func loadPass(cardNo: String) -> PKPass? {
//        var passName: String?
//        
//        if cardNo == "1" {
//            passName = "pass"
//        } else if cardNo == "2" {
//            passName = "Aviva"
//        } else if cardNo == "3" {
//            passName = "Lic"
//        }
//        
//        guard let url = Bundle.main.url(forResource: passName, withExtension: "pkpass") else {
//            print("❌ pass.pkpass file not found in bundle")
//            return nil
//        }
//
//        do {
//            let passData = try Data(contentsOf: url)
//            let pass = try PKPass(data: passData)
//            return pass
//        } catch {
//            print("❌ Failed to load PKPass: \(error)")
//            return nil
//        }
//    }
    
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

//    func presentWalletPass(cardNo: String) {
//        guard let pass = loadPass(cardNo: cardNo),
//              let addVC = PKAddPassesViewController(pass: pass) else {
//            print("❌ Wallet VC not available")
//            return
//        }
//
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let window = scene.windows.first,
//           let rootVC = window.rootViewController {
//            DispatchQueue.main.async {
//                rootVC.present(addVC, animated: true)
//            }
//        }
//    }
    
    func presentWalletPass(with parameters: [String: Any]) {
        let urlString: String = "https://3d372ef31224.ngrok-free.app/wallet-service/create-apple-pass"
           requestPass(from: urlString, with: parameters) { pass in
               guard let pass = pass,
                     let addVC = PKAddPassesViewController(pass: pass) else {
                   print("❌ Could not present Wallet VC")
                   return
               }
               self.pkPass = pass
//               addVC.delegate = self
               
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

//extension PassService: PKAddPassesViewControllerDelegate {
//    
//    func addPassesViewControllerDidFinish(_ controller: PKAddPassesViewController) {
//        let passLib = PKPassLibrary()
//        guard let passDetails = self.pkPass else { return }
//        
//        let arrayOfPasses = passLib.passes()
//        print("The count of passes are: ", arrayOfPasses.count)
//        
//        if passLib.containsPass(passDetails) {
//            // Its added in wallet
//            print("Its added in wallet")
//        } else {
//            // not present in wallet
//            print("not present in wallet")
//        }
//    }
//}
