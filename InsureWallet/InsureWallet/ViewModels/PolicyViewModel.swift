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
            self.policies = [
                       Policy(
                           id: "1",
                           policyName: "Flexible Life Protection",
                           insuranceType: "Life Insurance",
                           provider: "Sun Life",
                           policyNumber: "992066968B",
                           coveredUntil: "01 Jan 2027",
                           logoUrl: "shield.checkerboard" // Use SF Symbol for now
                       ),
                       Policy(
                           id: "2",
                           policyName: "Life Protection Policy",
                           insuranceType: "Life Insurance",
                           provider: "Aviva",
                           policyNumber: "2233448855",
                           coveredUntil: "01 Jun 2026",
                           logoUrl: "shield.checkerboard"
                       )
                       ]
        }
        isLoading = false
    }
}
