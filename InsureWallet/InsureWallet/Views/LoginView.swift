//
//  LoginView.swift
//  InsureWallet
//
//  Created by Bhavitha Gottimukkula on 16/07/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @State private var showPassword = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer(minLength: 50)
                
                //Logo
               Image("ScottishWidows")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Enter your email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    
                ZStack(alignment: .trailing) {
                    Group {
                        if showPassword {
                            TextField("Enter your password", text: $viewModel.password)
                        } else {
                            SecureField("Enter your password", text: $viewModel.password)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Text(showPassword ? "Hide" : "Show")
                            .foregroundStyle(.red)
                            .padding(.trailing, 16)
                    }
                }
               
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 4)
                }
                
                Button("Forgot Password?") {
                    //Navigation
                }
                .foregroundColor(.red)
                .font(.footnote)
                
                //Login Button
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Log in")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .cornerRadius(25)
                }
                .padding(.top)
                NavigationLink(destination: HomeView()) {
                    Text("Register")
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                InsurancePolicyView()
            }
            .background(.white)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

#Preview {
    LoginView()
}
