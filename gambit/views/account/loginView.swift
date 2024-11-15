//
//  loginView.swift
//  node
//
//  Created by Nick Mantini on 10/31/24.
//

import SwiftUI
import _AuthenticationServices_SwiftUI
import SwiftKeychainWrapper

struct loginView: View {
    @EnvironmentObject var alertViewModel: AlertViewModel
    @ObservedObject var accountModel: Account
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                VStack {
                    Image("office1")
                        .renderingMode(.original)
                        .resizable()
                        .clipped()
                        .overlay(alignment: .topLeading) {
                            VStack(alignment: .leading, spacing: 11) {
                                RoundedRectangle(cornerRadius: 17, style: .continuous)
                                    .fill(.yellow)
                                    .frame(width: 72, height: 72)
                                    .clipped()
                                    .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue: 0/255).opacity(0.12), radius: 8, x: 0, y: 4)
                                    .overlay {
                                        Image("nodeLogoWhite")
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40)
                                            .clipped()
                                    }
                                
                                VStack(alignment: .leading, spacing: 1) {
                                    Text("Node")
                                        .font(.system(.largeTitle, weight: .semibold))
                                    Text("Stay Connected, Effortlessly.")
                                        .font(.system(.title3, weight: .medium))
                                        .frame(width: 250, alignment: .leading)
                                        .clipped()
                                }
                                .foregroundStyle(.white)
                            }
                            .padding()
                            .padding(.top, 20)
                        }
                        .mask {
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                        }
                        .padding()
                        .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue: 0/255).opacity(0.35), radius: 18, x: 0, y: 14)
                        .overlay(alignment: .bottom) {
                            HStack {
                                Image(systemName: "point.3.connected.trianglepath.dotted")
                                    .imageScale(.large)
                                    .rotationEffect(.degrees(20))
                            
                                Text("Designed for Property Managers, HOAs, and More")
                                    .font(.system(size: 16, weight: .regular))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .padding(.vertical)
                            .padding(.horizontal, 30)
                            .background {
                                Rectangle()
                                    .fill(.clear)
                                    .background(Material.thin)
                                    .mask {
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    }
                            }
                            .padding()
                            .padding([.bottom, .horizontal],8)
                        }
                }

                VStack(spacing: 20) {
                    SignInWithAppleButton(.signUp) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        switch result {
                            case .success(let authResult):
                                handleSuccessfullSignin(with: authResult)
                            case .failure(let error):
                                handleLoginError(with: error)
                            }
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    
                    Text("View pricing")
                        .font(.headline.weight(.regular))
                }
                .padding(.horizontal)
                .padding(.bottom, 5)

                Spacer()
            }
            .padding(.horizontal, 5)
            .padding(.bottom, 70)
            .background(Color("backgroundColor"))
        }
    }
    
    private func handleSuccessfullSignin(with authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential, let identityToken = credentials.identityToken, let identityTokenString = String(data: identityToken, encoding: .utf8) else { return }
                
        accountModel.authenticateUser(authToken: identityTokenString, appleId: credentials.user, fullName: (credentials.fullName?.formatted())!, email: credentials.email ?? "")
         
         KeychainWrapper.standard.set(credentials.user, forKey: "appleId")
    }
        
    private func handleLoginError(with error: Error) {
        print("Could not authenticate: \\(error.localizedDescription)")
    }
}
