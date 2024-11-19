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
        .toast(isPresenting: $alertViewModel.show, duration: 3, offsetY: 9) {
            alertViewModel.alertToast
        }
        .tint(.white)
        .onAppear {
//            var appleId: String? = KeychainWrapper.standard.string(forKey: "appleId")
//            appleId = "001188.d2291cda8c794c92b3638ae3fc829cf4.0132"
//            if (appleId != nil) {
//                accountModel.appleAuthenticationLogin(authToken: "", appleId: appleId!, fullName: "", email: "")
//            }
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
    @Published var alertToast = AlertToast(type: .regular, title: "SOME TITLE"){
        didSet{
            show.toggle()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AlertViewModel())
}
