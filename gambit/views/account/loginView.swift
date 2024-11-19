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
    @State var loginType: LoginType
    @State var currentView: LoginViewType = .defaultView

    var body: some View {
        VStack() {
            header
            
            Spacer()

            loginMethodsView(accountModel: self.accountModel, loginType: self.loginType, currentView: self.$currentView)
                .environmentObject(self.alertViewModel)
              
            Spacer()
            
            if self.currentView != .signUpWithPhone {
                promoImage
            }
        }
        .padding(.horizontal, 25)
        .background {
            BackgroundView()
        }
        .edgesIgnoringSafeArea(self.currentView != .signUpWithPhone ? .bottom : .leading)
    }
    
    @ViewBuilder
    private var header: some View {
        VStack(spacing: 0) {
            Text("Gambit")
                .foregroundStyle(.brightGreen)
                .font(.largeTitle.weight(.black))
            
            Text("Play Smart, Win Big.")
                .font(.title3.weight(.regular))
                .kerning(1)
        }
    }

    @ViewBuilder
    private var promoImage: some View {
        Image("ufcPromoLogo")
            .resizable()
            .scaledToFit()
    }
}

enum LoginType {
case SignUp
case SignIn
}
