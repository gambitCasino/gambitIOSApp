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
            BackgroundView()
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
        .onAppear {
        }
    }
    
    @ViewBuilder private var profileDisplay: some View {
        VStack {
            HStack {
                Text(accountModel.isLoggedIn ? accountModel.account.username : "please login")
                    .font(.title2.weight(.bold))
                
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
            HStack {
                VStack(spacing: 0) {
                    Image("exploreCasino")
                        .resizable()
                        .scaledToFit()
                        .clipShape(
                            .rect(
                                topLeadingRadius: 11,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 11
                            )
                        )
                    
                    HStack(spacing: 10) {
                        Image(systemName: "dice.fill")
                            .rotationEffect(.degrees(-15))
                        Text("Casino")
                            .font(.title3.weight(.medium))
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(RoundedCorners(color: .duskGreen, tl: 0, tr: 0, bl: 12, br: 12))
                }
                
                VStack(spacing: 0) {
                    Image("exploreSportsBook")
                        .resizable()
                        .scaledToFit()
                        .clipShape(
                            .rect(
                                topLeadingRadius: 11,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 11
                            )
                        )
                    
                    HStack(spacing: 9) {
                        Image(systemName: "basketball.fill")
                            .rotationEffect(.degrees(-15))
                        Text("Sportsbook")
                            .font(.title3.weight(.medium))
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(RoundedCorners(color: .duskGreen, tl: 0, tr: 0, bl: 12, br: 12))
                }
            }
            
            VStack(spacing: 0) {
                HStack(spacing: 9) {
                    Image(systemName: "flame.fill")
                        .rotationEffect(.degrees(-15))
                    Text("Gambit Originals")
                        .font(.title3.weight(.medium))
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .background(RoundedCorners(color: .duskGreen, tl: 12, tr: 12, bl: 12, br: 12))
            }
            
            gamesHomeView(accountModel: self.accountModel)
            
            HStack {
                VStack(spacing: 0) {
                    HStack(spacing: 9) {
                        Image("slotsIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(.white)
        
                        Text("Slots")
                            .font(.title3.weight(.medium))
                        Spacer()
                        
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(RoundedCorners(color: .duskGreen, tl: 12, tr: 12, bl: 12, br: 12))
                }
                
                VStack(spacing: 0) {
                    HStack(spacing: 9) {
                        Image(systemName: "flame.fill")
                            .rotationEffect(.degrees(-15))
                        Text("Live Casino")
                            .font(.title3.weight(.medium))
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(RoundedCorners(color: .duskGreen, tl: 12, tr: 12, bl: 12, br: 12))
                }
            }
        }
    }
}
