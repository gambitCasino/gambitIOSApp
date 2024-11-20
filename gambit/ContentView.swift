//
//  ContentView.swift
//  node
//
//  Created by Nick Mantini on 10/28/24.
//

import SwiftUI
import AlertToast
import SwiftKeychainWrapper
import SVGView

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    @EnvironmentObject var alertViewModel: AlertViewModel
    @StateObject private var accountModel: Account = Account()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    switch selectedTab {
                    case .home:
                        homeView(accountModel: self.accountModel)
                            .environmentObject(alertViewModel)
                        
                    case .casino:
                        Text("Casino View")
                            .foregroundColor(.white)
                    case .bets:
                        Text("Bets View")
                            .foregroundColor(.white)
                    case .sports:
                        Text("Sports View")
                            .foregroundColor(.white)
                    case .chat:
                        Text("Chat View")
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("deepBlack").edgesIgnoringSafeArea(.all))
                
                navbarView(selectedTab: $selectedTab)
            }
        }
        .toast(isPresenting: $alertViewModel.show, duration: 3, offsetY: 11) {
            alertViewModel.alertToast
        }
        .tint(.white)
        .onAppear {
            let appleId: String? = KeychainWrapper.standard.string(forKey: "appleId")
            let password: String? = KeychainWrapper.standard.string(forKey: "password")
            let phoneNumber: String? = KeychainWrapper.standard.string(forKey: "phoneNumber")
            
            if (appleId != nil) {
                accountModel.appleAuthenticationLogin(appleId: appleId!, completion: { error in
                    
                })
            }
            else if (password != nil && phoneNumber != nil) {
                accountModel.phoneAuthenticaionLogin(phoneNumber: phoneNumber!, password: password!, completion: { error in
                    
                })
            }
        }
    }
}

@ViewBuilder public var pleaseLogin: some View {
    VStack {
        Spacer()
        Text("Please login first")
            .italic()
        Spacer()
    }
}

class AlertViewModel: ObservableObject{
    @Published var show = false
    @Published var alertToast = AlertToast(displayMode: .hud, type: .regular, title: "SOME TITLE"){
        didSet{
            show.toggle()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AlertViewModel())
}
