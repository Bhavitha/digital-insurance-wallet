//
//  PolicyDetailsHeaderView.swift
//  Digital Wallet
//
//  Created by Omkar Yeshvekar on 21/07/25.
//
import SwiftUI

struct PolicyDetailsHeaderView: View {
    let policy: Policy

    var body: some View {
        VStack {
            headerViewPolicyNameAndLogo()
            Spacer()
                .frame(height: 20)
            headerViewPolicyNumberAndDOE()
        }
        .background(Color(.systemGray5))
    }
    
    private func headerViewPolicyNameAndLogo() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(policy.name)
                    .font(.title)
                    .bold()
                Text(policy.policytype)
                    .font(.subheadline)
                Text("Provided by \(policy.provider)")
                    .font(.subheadline)
            }
            .foregroundColor(.black)
            Spacer()
            VStack(alignment: .trailing) {
                Image(systemName: policy.insurarLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)

            }
        }
        .background(Color(.systemGray5))
        .padding()
    }
    
    private func headerViewPolicyNumberAndDOE() -> some View {
        VStack {
            HStack {
                Text("Policy number")
                Spacer()
                Text("Policy ends")
            }
            .bold()
            HStack {
                Text(policy.policyNumber)
                Spacer()
                Text(policy.coveredUntil)
            }
        }
        .font(.subheadline)
        .background(Color(.systemGray5))
        .foregroundColor(.black)
        .padding()
    }
}

struct PolicyDetailsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let policy = Policy(id: "1",
                            name: "Scottish Widows",
                            insurarLogo: "apple.image.playground.fill",
                            policytype: "Property Insurance",
                            provider: "Aviva",
                            policyNumber: "PN123456",
                            coveredUntil: "25 July 2025")
        PolicyDetailsView(policy: policy)
    }
}
