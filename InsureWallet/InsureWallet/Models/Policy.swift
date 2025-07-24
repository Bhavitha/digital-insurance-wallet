//
//  Policy.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import Foundation

struct Policy: Identifiable, Decodable {
    let id: String
    let policyName: String
    let insuranceType: String
    let provider: String
    let policyNumber: String
    let coveredUntil: String
    let logoUrl: String

    private enum CodingKeys: String, CodingKey {
        case id
        case policyName, insuranceType, provider, policyNumber, coveredUntil, logoUrl
    }
}

struct PolicyResponse: Decodable {
    let status: String
    let data: [Policy]
}
