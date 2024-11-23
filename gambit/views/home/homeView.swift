//
//  messageView.swift
//  node
//
//  Created by Nick Mantini on 10/28/24.
//

import SwiftUI
import AlertToast

struct homeView: View {
    @EnvironmentObject var alertViewModel: AlertViewModel
    @ObservedObject var accountModel: Account
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(.lighterBlack)
                    .ignoresSafeArea(edges: .top)
                
                header
                    .padding(.horizontal, 17)
            }
            .frame(maxHeight: 55)
            .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue: 0/255).opacity(0.12), radius: 8, x: 0, y: 4)
            
            ScrollView(showsIndicators: false) {
                profileDisplay

                casinoHomePage
                
                Spacer()
            }
            
            .padding(.horizontal, 17)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            backgroundView()
        }
    }
    
    @ViewBuilder private var header: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Gambit")
                    .foregroundStyle(.brightGreen)
                    .font(.largeTitle.weight(.black))
                
                Spacer()
                
                if accountModel.isLoggedIn {
                    HStack(spacing: 5) {
                        Text("\(Int(self.accountModel.account.bits))")

                            .font(.title2.weight(.bold))
                        
                        Text("bits")
                            .font(.title3.weight(.medium))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color("deepCharcoal"))
                    }
                }
                else {
                    loginTypeButtons
                }
            }
        }
    }
    
    @ViewBuilder private var profileDisplay: some View {
        VStack {
            HStack {
                HStack(alignment: .lastTextBaseline, spacing: 25) {
                    Text(accountModel.isLoggedIn ? accountModel.account.username : "please login")
                        .font(.title2.weight(.bold))
                    
                    if accountModel.isLoggedIn {
                        Text("log out")
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(.red)
                            .onTapGesture {
                                self.accountModel.logOut()
                            }
                    }
                }
                Spacer()
                
                Image(systemName: "star.fill")
                    .foregroundStyle(self.accountModel.account.vipLevel.color)
                    .imageScale(.large)
            }
            .padding(.bottom, 15)

            VStack {
                HStack(alignment: .top) {
                    Text("Your VIP Progress")
                    Spacer()
                    Text("\(String(format: "%.0f", self.accountModel.account.vipProgress * 100))%")
                }
                
                LinearProgressView(value: self.accountModel.account.vipProgress, shape: RoundedRectangle(cornerRadius: 6))
                    .tint(LinearGradient(colors: [.green, .softMint], startPoint: .leading, endPoint: .trailing))
                    .frame(height: 16)
                
                HStack {
                    HStack(spacing: 3) {
                        Image(systemName: "star")
                            .foregroundStyle(self.accountModel.account.vipLevel.color)
                        Text("\(self.accountModel.account.vipLevel.displayName)")
                    }
                    
                    Spacer()
                                        
                    HStack(spacing: 3) {
                        Image(systemName: "star")
                            .foregroundStyle(self.accountModel.account.vipLevel.nextLevelColor)
                        Text("\(self.accountModel.account.vipLevel.nextLevel)")
                    }
                }
                .foregroundStyle(.gray)
            }
            .font(.headline)
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.deepCharcoal)
                .stroke(.duskGreen, lineWidth: 3)
        }
        .padding(.horizontal, 2)
        .padding(.vertical)
        .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue: 0/255).opacity(0.12), radius: 8, x: 0, y: 4)
    }
    
    @ViewBuilder
    private var loginTypeButtons: some View {
        HStack {
            NavigationLink(destination: loginView(accountModel: self.accountModel, loginType: .SignIn).environmentObject(alertViewModel)) {
                
                Text("Sign in")
                    .font(.headline.bold())
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.clear)
                    }
            }
            .buttonStyle(.plain)
            
            NavigationLink(destination: loginView(accountModel: self.accountModel, loginType: .SignUp).environmentObject(alertViewModel)) {
                
                Text("Sign up")
                    .font(.headline.bold())
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.duskGreen)
                    }
            }
            .buttonStyle(.plain)
        }
    }
    
    
    @ViewBuilder private var casinoHomePage: some View {
        VStack(spacing: 13) {
            GameGrid(items: [
                (title: "Slots", imageName: "exploreCasino", iconName: "slotsIcon", iconRotation: 0, backgroundColor: .duskGreen, destination: nil),
                (title: "Sportsbook", imageName: "exploreSportsBook", iconName: "basketball.fill", iconRotation: -15, backgroundColor: .duskGreen, destination: nil)
            ])
            
            GameCard(
                title: "Gambit Originals",
                iconName: "flame.fill",
                backgroundColor: .duskGreen
            )

            GameGrid(items: [
                (title: "Crash", imageName: "crash", iconName: nil, iconRotation: 0, backgroundColor: .duskGreen, destination: AnyView(crashView())),
                (title: "Dice", imageName: "dice", iconName: nil, iconRotation: 0, backgroundColor: .duskGreen, destination: AnyView(diceView())),
                (title: "Plinko", imageName: "plinko", iconName: nil, iconRotation: 0, backgroundColor: .duskGreen, destination: AnyView(plinkoView(accountModel: self.accountModel)
                    .environmentObject(alertViewModel))),
                (title: "Mines", imageName: "mines", iconName: nil, iconRotation: 0, backgroundColor: .duskGreen, destination: AnyView(minesView())),
            ])
        }
    }
}
