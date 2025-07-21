//
//  PolicyListView.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import SwiftUI

struct PolicyListView: View {
    @StateObject private var viewModel = PolicyViewModel()
    
    let policies = [
                Policy(id: "1",
                    title: "Flexible Life Protection",
                    subtitle: "Life Insurance",
                    provider: "Sun Life",
                    policyNumber: "992066968B",
                    coveredUntil: "01 Jan 2027"
                ),
                Policy(id: "2",
                    title: "Life Protection Policy",
                    subtitle: "Life Insurance",
                    provider: "Aviva",
                    policyNumber: "2233448855",
                    coveredUntil: "01 Jun 2026"
                ),
                Policy(id: "3",
                    title: "Term Life Shield",
                    subtitle: "Term Plan",
                    provider: "LIC",
                    policyNumber: "LIC9033822",
                    coveredUntil: "01 Dec 2028"
                )
            ]

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    LazyVStack()  {
                        ForEach(policies) { policy in
                            PolicyCardView(policy: policy)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                }
            }
            .navigationTitle("Life Cover")
        }
        .task {
            await viewModel.loadPolicies()
        }
    }
}

