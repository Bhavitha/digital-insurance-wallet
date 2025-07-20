//
//  InsurancePolicyView.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 20/07/25.
//

import SwiftUI

struct InsurancePolicyView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                PolicyCard(title: "Life Protection Policy", subTitle: "Life Insurance", provider: "Aviva", policyNumber: "123456", expiry: "01 jun 2026", showIcon: false)
            }
            .padding()
            .navigationBarTitle("Insurance Policy", displayMode: .inline)
            
        }
    }
}

#Preview {
    InsurancePolicyView()
}
