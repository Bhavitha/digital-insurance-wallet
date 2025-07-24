//
//  PolicyCard.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 20/07/25.
//

import SwiftUI
import PassKit

struct PolicyCardView: View {
    
    @State private var isPassAdded = false
    let policy: Policy
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(policy.policyName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(policy.provider)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
                
                Spacer()
                
                Image(systemName: policy.logoUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.red)
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Policy number")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(policy.policyNumber)
                        .font(.body)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Covered until")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(policy.coveredUntil)
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
            .padding(.top)
            
            // MARK: Add to Apple Wallet Button
            // Wallet Button
                   /*   Button(action: {
                          let parameters: [String: Any] = [
                              "policyNumber": policy.policyNumber,
                              "policyName": policy.policyName,
                              "expiry": policy.coveredUntil
                          ]
                        PassService.shared.presentWalletPass(cardNo: policy.id     )
//                          PassService.shared.presentWalletPass(
//                              from: "https://b0ca12ae326d.ngrok-free.app/wallet-service/create-apple-pass",
//                              with: parameters)
//                          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                              isAddedToWallet = true
//                          }
                      }) {
                          AddToWalletButton(isPassAdded: $isPassAdded)
                              .frame(height: 44)
                              .frame(maxWidth: .infinity)
                      }*/
                      
            HStack {
                Button(action: {
                    let parameters: [String: Any] = [
                        "policyNumber": policy.policyNumber,
                        "policyName": policy.policyName,
                        "expiry": policy.coveredUntil
                    ]
                    PassService.shared.presentWalletPass(cardNo: policy.id)
/*                   PassService.shared.presentWalletPass(with: parameters)
                    PassService.shared.presentWalletPass(
                        from: "https://b0ca12ae326d.ngrok-free.app/wallet-service/create-apple-pass",
                        with: parameters)*/
                    
                    // Simulate expiry notification after 10 seconds
                    NotificationService.shared.schedulePolicyExpiryNotification(policyName: policy.policyName, secondsFromNow: 10)
                }, label: {
                    HStack(spacing: 10) {
                        Image("applewallet", bundle: nil)
                        VStack(alignment: .leading) {
                            Text("Add to")
                                .font(.footnote)
                            Text("Apple Wallet")
                                .font(.footnote)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                })
                .background(Color.black)
                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 10,
                                                                   bottomLeading: 10,
                                                                   bottomTrailing: 10,
                                                                   topTrailing: 10)))
                .padding(.top, 10)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 4)
    }
}

/*struct AddToWalletButton: UIViewRepresentable {
    @Binding var isPassAdded: Bool

    func makeUIView(context: Context) -> PKAddPassButton {
        let button = PKAddPassButton(addPassButtonStyle: .black)
        button.addTarget(context.coordinator, action: #selector(Coordinator.addPass), for: .touchUpInside)
        return button
    }

    func updateUIView(_ uiView: PKAddPassButton, context: Context) {
        uiView.isHidden = isPassAdded // 👈 Hides the button if pass is added
        uiView.isEnabled = !isPassAdded // (Optional) Disables the button instead
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isPassAdded: $isPassAdded)
    }

    class Coordinator: NSObject {
        var isPassAdded: Binding<Bool>

        init(isPassAdded: Binding<Bool>) {
            self.isPassAdded = isPassAdded
        }

        @objc func addPass() {
            // Load pass from bundle or URL
            guard let passURL = Bundle.main.url(forResource: "pass", withExtension: "pkpass"),
                  let passData = try? Data(contentsOf: passURL),
                  let pass = try? PKPass(data: passData) else {
                print("Failed to load pass.")
                return
            }

            let addPassVC = PKAddPassesViewController(pass: pass)
            if let topVC = UIApplication.shared.windows.first?.rootViewController {
                topVC.present(addPassVC!, animated: true) {
                    self.isPassAdded.wrappedValue = true // ✅ Update state
                }
            }
        }
    }
}*/
