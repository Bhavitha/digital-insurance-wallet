//
//  InsureWalletApp.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 16/07/25.
//

import SwiftUI

@main
struct InsureWalletApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView()
            }
        }
    }
}
