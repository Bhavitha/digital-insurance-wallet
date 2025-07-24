//
//  AppDelegate.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 19/07/25.
//

import UIKit
import Firebase
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        NotificationService.shared.requestPermission()
        return true
    }

}
