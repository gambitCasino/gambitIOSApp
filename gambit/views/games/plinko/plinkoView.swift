//
//  crashView.swift
//  gambit
//
//  Created by Nick Mantini on 11/20/24.
//

import SwiftUI
import SpriteKit

struct plinkoView: View {
    @EnvironmentObject var alertViewModel: AlertViewModel
    @ObservedObject var accountModel: Account
        
    @State private var scene: plinkoGameScene = {
        let scene = plinkoGameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scene.scaleMode = .fill
        return scene
    }()
    
    @State private var betAmmount: Double = 1.0
    @State private var autoSpinCount = 0
    @State private var isAutoSpinning = false
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                .ignoresSafeArea()
            
            VStack {
                HStack(spacing: 10) {
                    HStack(spacing: 4) {
                        Image("wallet")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
//                        Text("GC")
//                            .font(.title3.weight(.heavy))
                    }
                    Text("\(Int(self.accountModel.account.bits))")
                        .font(.title2.weight(.medium))
                    
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color("deepCharcoal"))
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                
                Spacer()

                HStack {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Bet Amount")
                                .font(.title2.bold())
                            
                            TextField("Bet Amount", value: self.$betAmmount, formatter: currencyFormatter)
                                .keyboardType(.numberPad)
                                .padding(8)
                                .font(.title2)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.white, lineWidth: 1)
                                )
                                .fixedSize()
                        }
                        
                        HStack(spacing: 10) {
                            VerticalStepper(value: $betAmmount, range: 0.00...100000.0, step: 0.1, color: .brightGreen, bgColor: .gray)
                           
                            Text("Bet")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 25)
                                .frame(maxWidth: .infinity)
                                .background(.brightGreen)
                                .cornerRadius(10)
                                .onTapGesture {
                                    
                                    scene.dropBall()
                                }
                                .fixedSize()
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 35) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Auto bet")
                                .font(.title2.bold())
                            
                            VStack(spacing: 10) {
                                TextField("", value: self.$autoSpinCount, format: .number)
                                    .keyboardType(.numberPad)
                                    .padding(8)
                                    .font(.title2)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.white, lineWidth: 1)
                                    )
                                //                                        .fixedSize()
                                    .frame(maxWidth: UIScreen.main.bounds.width*0.23)
                            }
                        }
                        
                        Text("Start")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 25)
                            .frame(maxWidth: .infinity)
                            .background(.brightGreen)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .fixedSize()
                    }
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 65)
            }
        }
    }
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

struct MultiplierSlot {
    let multiplier: Double
    let color: Color
}
