//
//  WalletManager.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import Foundation
import PassKit

class WalletManager {
    static let shared = WalletManager()

    func canAddPasses() -> Bool {
        PKAddPassesViewController.canAddPasses()
    }

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
}
