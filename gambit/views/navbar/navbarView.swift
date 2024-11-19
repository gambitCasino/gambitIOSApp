//
//  narbar.swift
//  gambit
//
//  Created by Nick Mantini on 11/16/24.
//

struct TabBarButton: View {
    let icon: String
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(isSelected ? .white : .gray)
            
            Text(text)
                .font(.caption)
                .foregroundColor(isSelected ? .white : .gray)
        }
        .padding(.horizontal, 15)
        .onTapGesture {
            action()
        }
    }
}

// Enum for tabs
enum Tab {
    case browse
    case casino
    case bets
    case sports
    case chat
}
