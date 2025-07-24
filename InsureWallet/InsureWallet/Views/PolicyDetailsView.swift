//
//  PolicyDetailsView.swift
//  Digital Wallet
//
//  Created by Omkar Yeshvekar on 20/07/25.
//

import SwiftUI

struct PolicyDetailsView: View {
    let policy: Policy
    
    var body: some View {
        VStack {
            PolicyDetailsHeaderView(policy: policy)
            Spacer()
                .frame(height: 30)
            policyOptionsView()
            Spacer()
        }
        .navigationTitle("Policy Details")
        .navigationBarTitleDisplayMode(.inline)
        .tint(.black)
    }
    
    private func policyOptionsView() -> some View {
        VStack(alignment: .center) {
            Text("Action")
            Divider()
            Text("Make a claim")
            Divider()
            Text("Manage your renewal")
            Divider()
            Text("View document")
            Divider()
            Text("Contact us")
        }
        .background(Color.white)
    }
}

//struct PolicyDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let policy = Policy(id: "1",
//                            policyName: "Scottish Widows",
//                            insurarLogo: "apple.image.playground.fill",
//                            policytype: "Property Insurance",
//                            provider: "Aviva",
//                            policyNumber: "PN123456",
//                            coveredUntil: "25 July 2025")
//        PolicyDetailsView(policy: policy)
//    }
//}
