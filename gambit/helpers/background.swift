//
//  background.swift
//  gambit
//
//  Created by Nick Mantini on 11/18/24.
//

import SwiftUI


struct backgroundView: View {
    var body: some View {
        ZStack {
            // Base color
//            LinearGradient(gradient: Gradient(colors: [.evenLighterBlack, .lighterBlack, .deepBlack, .evenLighterBlack]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
            
            LinearGradient(gradient: Gradient(colors: [.deepBlack, .lighterBlack, .evenLighterBlack]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

