//
//  PolicyListView.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import SwiftUI

struct PolicyListView: View {
    @StateObject private var viewModel = PolicyViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    addCardsIntoScrollView(policies: createPolicyArray())
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Policies")
            .navigationBarTitleDisplayMode(.large)
        }
        .tint(.black)
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.loadPolicies()
        }
    }
    
    private func addCardsIntoScrollView(policies: [Policy]) -> some View {
        LazyVStack(spacing: 16) {
            ForEach(policies) { policy in
                NavigationLink(destination: PolicyDetailsView(policy: policy),
                               label: {
                    PolicyCardView(policy: policy)
                        .shadow(radius: 5)
                })
            }
        }
        .padding()
    }
    
    private func createPolicyArray() -> [Policy] {
        let policies = [
                    Policy(id: "1",
                           name: "Flexible Life Protection",
                           insurarLogo: "shield.checkerboard",
                           policytype: "Life Insurance",
                           provider: "Scottish Widows",
                           policyNumber: "992066968B",
                           coveredUntil: "01 Jan 2027"
                          ),
                    Policy(id: "2",
                           name: "Life Protection Policy",
                           insurarLogo: "lasso.badge.sparkles",
                           policytype: "Life Insurance",
                           provider: "Aviva",
                           policyNumber: "2233448855",
                           coveredUntil: "01 Jun 2026"
                          ),
                    Policy(id: "3",
                           name: "Term Life Shield",
                           insurarLogo: "staroflife.shield.fill",
                           policytype: "Term Plan",
                           provider: "LIC",
                           policyNumber: "LIC9033822",
                           coveredUntil: "01 Dec 2028"
                          )
                    ]
        return policies
    }
}

