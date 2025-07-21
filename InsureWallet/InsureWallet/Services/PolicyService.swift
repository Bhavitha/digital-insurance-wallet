//
//  PolicyService.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import Foundation

class PolicyService {
    static let shared = PolicyService()

    func fetchPolicies() async throws -> [Policy] {
        guard let url = URL(string: "https://updatedomain/policies") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Policy].self, from: data)
    }
}
