//
//  PolicyCard.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 20/07/25.
//

import SwiftUI
import PassKit

struct PolicyCardView: View {
    
    @State private var isPassAdded = false
    let policy: Policy
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(policy.policyName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(policy.provider)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
                
                Spacer()
                
                Image(systemName: policy.logoUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.red)
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Policy number")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(policy.policyNumber)
                        .font(.body)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Covered until")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(policy.coveredUntil)
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
            .padding(.top)
            
            // MARK: Add to Apple Wallet Button
            
            HStack {
                Button(action: {
                    let parameters: [String: Any] = [
                        "policyNumber": policy.policyNumber,
                        "policyName": policy.policyName,
                        "expiry": policy.coveredUntil,
                        "userId": "reboot@gmail.com"
                    ]
//                    PassService.shared.presentWalletPass(cardNo: policy.id)
                   PassService.shared.presentWalletPass(with: parameters)
                    
                    // Simulate expiry notification after 10 seconds
                    NotificationService.shared.schedulePolicyExpiryNotification(policyName: policy.policyName, secondsFromNow: 10)
                }, label: {
                    HStack(spacing: 10) {
                        Image("applewallet", bundle: nil)
                        VStack(alignment: .leading) {
                            Text("Add to")
                                .font(.footnote)
                            Text("Apple Wallet")
                                .font(.footnote)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                })
                .background(Color.black)
                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 10,
                                                                   bottomLeading: 10,
                                                                   bottomTrailing: 10,
                                                                   topTrailing: 10)))
                .padding(.top, 10)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 4)
    }
}
