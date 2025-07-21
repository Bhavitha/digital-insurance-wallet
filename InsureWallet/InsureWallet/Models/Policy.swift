//
//  Policy.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 21/07/25.
//

import Foundation

struct Policy: Identifiable, Decodable {
    let id: String
    let title: String
    let subtitle: String
    let provider: String
    let policyNumber: String
    let coveredUntil: String
}
