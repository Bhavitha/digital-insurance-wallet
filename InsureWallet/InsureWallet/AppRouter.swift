//
//  AppRouter.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 02/09/25.
//

import SwiftUI
final class AppRouter: ObservableObject {
    enum Route: Hashable {
        case policyDetails
    }

    @Published var path = NavigationPath()

    func openPolicyDetails() {
        path.append(Route.policyDetails)
    }
}
