//
//  gameView.swift
//  gambit
//
//  Created by Nick Mantini on 11/20/24.
//

import SwiftUI

struct gamesHomeView: View {
    @EnvironmentObject var alertViewModel: AlertViewModel
    @ObservedObject var accountModel: Account
    
    let games = [
        ("Crash", "crash"),        // Name and image asset name
        ("Dice", "dice"),
        ("Plinko", "plinko"),
        ("Mines", "mines")
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(games, id: \.0) { game in
                    VStack(spacing: 0) {
                        Image(game.1)
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
                            Text(game.0)
                                .font(.title3.weight(.medium))
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(RoundedCorners(color: .duskGreen, tl: 0, tr: 0, bl: 12, br: 12))
                    }
                }
            }
        }
    }
}
