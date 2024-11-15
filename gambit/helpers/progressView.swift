//
//  progressView.swift
//  gambit
//
//  Created by Nick Mantini on 11/15/24.
//

import SwiftUI

struct LinearProgressView<Shape: SwiftUI.Shape>: View {
    var value: Double
    var shape: Shape

    var body: some View {
        shape.fill(.foreground.quaternary)
            .overlay(alignment: .leading) {
                GeometryReader { proxy in
                    shape.fill(.tint)
                        .frame(width: proxy.size.width * value)
                }
            }
            .clipShape(shape)
    }
}
