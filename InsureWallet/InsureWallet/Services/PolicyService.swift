//
//  PolicyService.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import Foundation

class PolicyService {
    static var shared = PolicyService()

    func fetchPolicies() async throws -> PolicyResponse {
        guard let url = URL(string: "https://108053cc65ef.ngrok-free.app/policy-service/policy-details") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PolicyResponse.self, from: data)
    }
}
