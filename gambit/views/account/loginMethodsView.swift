//
//  loginMethodsView.swift
//  gambit
//
//  Created by Nick Mantini on 11/17/24.
//

import SwiftUI
import _AuthenticationServices_SwiftUI
import SwiftKeychainWrapper
import AlertToast

struct loginMethodsView: View {
    @EnvironmentObject var alertViewModel: AlertViewModel
    @ObservedObject var accountModel: Account
    @State var loginType: LoginType
    @Binding var currentView: LoginViewType
    
    @Environment(\.dismiss) private var dismiss

    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            if currentView == .defaultView {
                if loginType == .SignIn {
                    signIn
                } else {
                    signUp
                }
            }
            else if currentView == .signUpWithPhone {
                signUpWithPhone
            }
            else if currentView == .signInWithPhone {
                signInWithPhone
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 30)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.deepCharcoal)
                .stroke(.duskGreen, lineWidth: 3)
        }
    }
    
    @ViewBuilder private var signIn: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Sign in")
                        .font(.title.bold())
                    
                    Spacer()
                }
                
                Text("Welcome back! Login to your account below")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    currentView = .signInWithPhone
                }
            }) {
                HStack {
                    Spacer()
                    
                    Image(systemName: "phone.fill")
                    
                    Text("Sign in with Phone")
                        .font(.title3.bold())
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .frame(height: 50)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.brightGreen)
                }
            }
            
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authResult):
                    handleAppleAuth(with: authResult)
                case .failure(let error):
                    handleAppleError(with: error)
                    handlePostLogin(error: (code: "APPLE_AUTH_ERROR", message: "Apple authenticaion error, try again later"))
                }
            }
            .signInWithAppleButtonStyle(.white)
            .frame(height: 50)
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
    
    @ViewBuilder private var signUp: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Sign up")
                        .font(.title.bold())
                    
                    Spacer()
                }
                
                Text("Join now and instantly claim your exclusive welcome bonus!")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    currentView = .signUpWithPhone
                }
            }) {
                HStack {
                    Spacer()
                    
                    Image(systemName: "phone.fill")
                    
                    Text("Sign up with Phone")
                        .font(.title3.bold())
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .frame(height: 50)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.brightGreen)
                }
            }
            
            SignInWithAppleButton(.signUp) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authResult):
                    handleAppleAuth(with: authResult)
                case .failure(let error):
                    handleAppleError(with: error)
//                    handlePostLogin(error: (code: "APPLE_AUTH_ERROR", message: "Apple authenticaion error, try again later"))
                }
            }
            .signInWithAppleButtonStyle(.white)
            .frame(height: 50)
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
    
    @ViewBuilder private var signUpWithPhone: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Text("Phone Sign Up")
                    .font(.title.bold())
                
                Text("Enter details to create your account")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            TextField("Username", text: $username)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.duskGreen, lineWidth: 2)
                )
            
            TextField("Phone Number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.duskGreen, lineWidth: 2)
                )
            
            SecureField("Password", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.duskGreen, lineWidth: 2)
                )
            
            Button(action: {
                accountModel.phoneAuthenticaionLogin(phoneNumber: self.phoneNumber, password: self.password, username: self.username) { error in
                    handlePostLogin(error: error)
                }
            }) {
                Text("Continue")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.brightGreen))
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    currentView = .defaultView
                }
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .padding(.trailing)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.deepCharcoal))
    }
    
    @ViewBuilder private var signInWithPhone: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Text("Phone Sign In")
                    .font(.title.bold())
                
                Text("Enter your details below")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            TextField("Phone Number", text: self.$phoneNumber)
                .keyboardType(.phonePad)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.duskGreen, lineWidth: 2)
                )
            
            SecureField("Password", text: self.$password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.duskGreen, lineWidth: 2)
                )
            
            Button(action: {
                accountModel.phoneAuthenticaionLogin(phoneNumber: self.phoneNumber, password: self.password) { error in
                    handlePostLogin(error: error)
                }
            }) {
                Text("Continue")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.brightGreen))
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    currentView = .defaultView
                }
            }) {
                HStack() {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .padding(.trailing)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.deepCharcoal))
    }
    
    private func handleAppleAuth(with authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = credentials.identityToken,
              let identityTokenString = String(data: identityToken, encoding: .utf8) else { return }
                
        accountModel.appleAuthenticationLogin(appleId: credentials.user, authToken: identityTokenString, fullName: (credentials.fullName?.formatted())!, email: credentials.email ?? "") { error in
            handlePostLogin(error: error)
        }
    }
        
    private func handleAppleError(with error: Error) {
        print("Could not authenticate: \(error.localizedDescription)")
    }
    
    public func handlePostLogin(error: ((code: String, message: String)?)) {
        if let (_, errorMsg) = error {
            alertViewModel.alertToast = AlertToast(displayMode: .hud, type: .error(.red), title: errorMsg)
        } else if self.accountModel.isLoggedIn {
            dismiss()
            
            alertViewModel.alertToast = AlertToast(displayMode: .hud, type: .complete(.brightGreen), title: "Welcome back!")
            
            KeychainWrapper.standard.set(self.password, forKey: "password")
            KeychainWrapper.standard.set(self.accountModel.account.appleId, forKey: "appleId")
            KeychainWrapper.standard.set(self.accountModel.account.phoneNumber, forKey: "phoneNumber")
        }
        else {
            alertViewModel.alertToast = AlertToast(displayMode: .hud, type: .error(.red), title: "An unkown error occurred, try again later.")
        }
    }
}

enum LoginViewType {
    case defaultView
    case signUpWithPhone
    case signInWithPhone
}
