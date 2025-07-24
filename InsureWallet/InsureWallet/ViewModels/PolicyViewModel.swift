//
//  PolicyViewModel.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import Foundation

@MainActor
class PolicyViewModel: ObservableObject {
    @Published var policies: [Policy] = []
    @Published var isLoading = false

    func loadPolicies() async {
        isLoading = true
        do {
            let policyResponse = try await PolicyService.shared.fetchPolicies()
            self.policies = policyResponse.data
           
        } catch {
            print("Failed to load policies: \(error)")
        }
        isLoading = false
    }
}
