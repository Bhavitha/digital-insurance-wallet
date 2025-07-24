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
                    policyCards
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
    
    private var policyCards: some View {
           LazyVStack(spacing: 16) {
               ForEach(viewModel.policies) { policy in
                   NavigationLink(destination: PolicyDetailsView(policy: policy)) {
                       PolicyCardView(policy: policy)
                           .shadow(radius: 5)
                   }
               }
           }
           .padding()
       }
}

