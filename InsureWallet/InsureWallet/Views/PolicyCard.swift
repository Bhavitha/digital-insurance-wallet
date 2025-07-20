//
//  PolicyCard.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 20/07/25.
//

import SwiftUI

struct PolicyCard: View {
    let title: String
    let subTitle: String
    let provider: String
    let policyNumber: String
    let expiry: String
    let showIcon: Bool
    
    var body: some View {
        NavigationView {
                   VStack(spacing: 24) {
                       
                       VStack(alignment: .leading, spacing: 16) {
                           HStack {
                               VStack(alignment: .leading, spacing: 4) {
                                   Text(title)
                                       .font(.headline)
                                   Text(subTitle)
                                       .font(.subheadline)
                                       .foregroundColor(.gray)
                                   Text(provider)
                                       .font(.subheadline)
                                       .foregroundColor(.gray)
                               }
                               Spacer()
                               Image(systemName: "shield.checkerboard")
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 36, height: 36)
                                   .foregroundColor(.red)
                           }

                           Divider()

                           HStack {
                               VStack(alignment: .leading, spacing: 4) {
                                   Text("Policy number")
                                       .font(.caption)
                                       .foregroundColor(.gray)
                                   Text(policyNumber)
                                       .font(.body)
                                       .fontWeight(.medium)
                               }

                               Spacer()

                               VStack(alignment: .leading, spacing: 4) {
                                   Text("Covered until")
                                       .font(.caption)
                                       .foregroundColor(.gray)
                                   Text(expiry)
                                       .font(.body)
                                       .fontWeight(.medium)
                               }
                           }

                           Button(action: {
                               // Add to Wallet action
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
                       .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)

                       Spacer()
                   }
                   .padding()
               }
           }
       }

#Preview {
    PolicyCard(title: "Life Protection Policy", subTitle: "Life Insurance", provider: "Aviva", policyNumber: "123456", expiry: "01 jun 2026", showIcon: false)
}
