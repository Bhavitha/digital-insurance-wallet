//
//  PolicyCard.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 20/07/25.
//

import SwiftUI
import PassKit

struct PolicyCardView: View {
    
    @State private var showWalletSheet = false
    let policy: Policy
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(policy.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(policy.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(policy.provider)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "shield.checkerboard")
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
            
            // Bottom: Add to Wallet Button
            Button(action: {
                WalletManager.shared.presentWalletPass()
            }) {
                HStack {
                    Image(systemName: "wallet.pass")
                    Text("Add to Wallet")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .cornerRadius(10)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 4)
    }
}
