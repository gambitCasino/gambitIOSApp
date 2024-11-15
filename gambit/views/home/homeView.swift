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
        VStack {
            ScrollView {
                header
                
                Divider()
                    .padding(.horizontal, 15)
                    
                profileDisplay

                exploreCasino
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder private var header: some View {
        HStack() {
//            HStack(spacing: 10) {
//                Image("slotsIcon")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 32, height: 32)
//                    .foregroundStyle(.white)
//                
//                Text("Gambit")
//                    .font(.largeTitle.weight(.bold))
//            }
//            .foregroundStyle(.offWhite)
            Image("titleLogoGCards")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            Spacer()
            
            HStack(spacing: 5) {
                Text("100")
                    .font(.title2.weight(.bold))

                Text("bits")
                    .font(.title3.weight(.medium))
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.deepCharcoal)
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 4)

    }
    
    @ViewBuilder private var profileDisplay: some View {
        VStack {
            HStack {
                Text("LandikBK")
                    .font(.title2.weight(.bold))
                
                Spacer()
                
                Image(systemName: "star")
                    .opacity(0.3)
                    .imageScale(.large)
            }
            .padding(.bottom, 25)

            VStack {
                HStack(alignment: .top) {
                    Text("Your VIP Progress")
                    Spacer()
                    Text("60%")
                }
                
                LinearProgressView(value: 0.6, shape: RoundedRectangle(cornerRadius: 6))
                    .tint(LinearGradient(colors: [.green, .softMint], startPoint: .leading, endPoint: .trailing))
                    .frame(height: 16)
                
                HStack {
                    HStack(spacing: 3) {
                        Image(systemName: "star")
                            .foregroundStyle(.gray)
                        Text("None")
                    }
                    
                    Spacer()
                                        
                    HStack(spacing: 3) {
                        Image(systemName: "star")
                            .foregroundStyle(.brown)
                        Text("Bronze")
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
        .padding(.vertical)
        .padding(.horizontal, 25)
        .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue: 0/255).opacity(0.12), radius: 8, x: 0, y: 4)
    }
    
    @ViewBuilder private var exploreCasino: some View {
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
            .padding(.horizontal, 25)
            
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
            .padding(.horizontal, 25)
            
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
            .padding(.horizontal, 25)

        }
    }
}
