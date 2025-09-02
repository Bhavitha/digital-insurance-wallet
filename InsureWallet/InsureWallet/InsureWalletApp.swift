//
//  InsureWalletApp.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 16/07/25.
//

import SwiftUI

@main
struct InsureWalletApp: App {
    @StateObject private var router = AppRouter()
    let policy = Policy (
     id: "1",
     policyName: "Flexible Life Protection",
     insuranceType: "Life Insurance",
     provider: "Prudential",
     policyNumber: "992066968B",
     coveredUntil: "01 Jan 2027",
     logoUrl: "shield.checkerboard"
    )
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                // Your current entry view; swap to LoginView if you gate by auth
                PolicyListView()
                    .navigationDestination(for: AppRouter.Route.self) { route in
                        switch route {
                        case .policyDetails:
                            PolicyDetailsView(policy: policy)
                        }
                    }
            }
            .onOpenURL { url in
                guard let link = PolicyDeepLink(url: url) else { return }
                if link.action == "renew" {
                    router.openPolicyDetails()
                }
            }
            .environmentObject(router)
        }
    }
}

struct PolicyDeepLink {
    let policyId: String
    let action: String?

    init?(url: URL) {
        guard url.scheme == "myapp",
              url.host == "policy" else { return nil }
        policyId = url.pathComponents.dropFirst().first ?? ""
        guard !policyId.isEmpty else { return nil }
        action = URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?.first(where: { $0.name == "action" })?.value
    }
}
