//
//  NotificationService.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 23/07/25.
//

import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()

    private init() {}

      func requestPermission() {
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
              print(granted ? "✅ Notifications allowed" : "❌ Notifications denied")
          }
      }

    /// Schedules a local notification for policy expiry
    func schedulePolicyExpiryNotification(policyName: String, secondsFromNow: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Policy Expiring Soon!"
        content.body = "\(policyName) is about to expire!"
        content.sound = .default

        // For demo: trigger in 10 seconds
        // In real app: calculate time difference between now and expiryDate
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(" Error scheduling notification: \(error)")
            } else {
                print(" Local notification scheduled for \(policyName)")
            }
        }
    }

    /// Helper to format date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

