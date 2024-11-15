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
    @State private var selectedTab: String = "Home"
    @State private var splashScreen = false
    @EnvironmentObject var alertViewModel: AlertViewModel
    @StateObject private var accountModel: Account = Account()
    
    var body: some View {
        NavigationView {
            VStack {
                if (!splashScreen) {
                    switch selectedTab {
                    case "Home":
                        homeView(accountModel: self.accountModel)
                            .environmentObject(alertViewModel)
                    case "Account":
                        if accountModel.isLoggedIn {
                            accountView(accountModel: self.accountModel).environmentObject(alertViewModel)
                        }
                        else {
                            loginView(accountModel: self.accountModel).environmentObject(alertViewModel)
                        }
                    default:
                        Text("")
                    }
                }
                else {
                    VStack {
                        Spacer()
                        Image("nodeLogoYellow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Text("node")
                            .font(.largeTitle.weight(.light))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .background(.deepBlack)
            .overlay(alignment: .bottom) {
                navBar
                    .opacity(!splashScreen ? 1 : 0)
            }
            .ignoresSafeArea(.keyboard)
    //        .toast(isPresenting: $alertViewModel.show, duration: 0) { // offsetY 11
    //            alertViewModel.alertToast
    //        }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.splashScreen = false
                }
            }
            
//            var appleId: String? = KeychainWrapper.standard.string(forKey: "appleId")
//            appleId = "001188.d2291cda8c794c92b3638ae3fc829cf4.0132"
//            if (appleId != nil) {
//                accountModel.authenticateUser(authToken: "", appleId: appleId!, fullName: "", email: "")
//                selectedTab = "Messages"
//            }
//            else {
//                selectedTab = "Account"
//            }
        }
    }
    
    @ViewBuilder private var navBar: some View {
        VStack(spacing: 0) {
            Divider()
            HStack(spacing: 10) {
                ForEach(NavBarEntrys) { navEntry in
                    VStack(spacing: 4) {
                        Image(navEntry.symbolName)
                            .imageScale(.large)
                            .frame(height: 25)
                            .clipped()
                    }
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .frame(height: 50)
                    .clipped()
                    .foregroundStyle(selectedTab == navEntry.title ? .white : .deepCharcoal)
                    .onTapGesture {
                        selectedTab = navEntry.title
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.top, 10)
        }
        .background {
            Rectangle()
                .fill(.clear)
                .background(.regularMaterial)
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

struct NavBarEntry: Identifiable {
    var title: String
    var symbolName: String
    
    var id: String {
        self.title
    }
}

let NavBarEntrys: [NavBarEntry] = [
    NavBarEntry(title: "Home", symbolName: "slotsIcon"),
    NavBarEntry(title: "Account", symbolName: "person"),
]

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
