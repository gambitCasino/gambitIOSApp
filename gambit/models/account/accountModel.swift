//
//  accountModel.swift
//  node
//
//  Created by Nick Mantini on 10/30/24.
//

import Foundation
import SwiftUICore

struct AccountModel: Codable {
    var _id: String = ""
    var appleId: String = ""
    var username: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var vipLevel: VIPLevel = .bronze
    var vipProgress: Double = 0.0
    var bits: Double = 0.0
    var createdAt: Date = Date()
    var isVerified: Bool = false

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode each property with a fallback default if the key is missing
        self._id = try container.decodeIfPresent(String.self, forKey: ._id) ?? ""
        self.appleId = try container.decodeIfPresent(String.self, forKey: .appleId) ?? ""
        self.username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        self.vipLevel = try container.decodeIfPresent(VIPLevel.self, forKey: .vipLevel) ?? .none
        self.vipProgress = try container.decodeIfPresent(Double.self, forKey: .vipProgress) ?? 0.0
        self.bits = try container.decodeIfPresent(Double.self, forKey: .bits) ?? 0.0
        
        if let createdAtString = try container.decodeIfPresent(String.self, forKey: .createdAt) {
            self.createdAt = Date.fromISOString(createdAtString) ?? Date() // Custom method to handle JS dates
        } else {
            self.createdAt = Date()
        }
        
        self.isVerified = try container.decodeIfPresent(Bool.self, forKey: .isVerified) ?? false
    }
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case _id
        case appleId
        case username
        case email
        case phoneNumber
        case vipLevel
        case vipProgress
        case bits
        case createdAt
        case isVerified
    }
    
    enum VIPLevel: Int, Codable {
        case none = 1
        case bronze
        case silver
        case gold
        case platinum
        case diamond
        case obsidian

        var displayName: String {
            switch self {
            case .none: return "None"
            case .bronze: return "Bronze"
            case .silver: return "Silver"
            case .gold: return "Gold"
            case .platinum: return "Platinum"
            case .diamond: return "Diamond"
            case .obsidian: return "Obsidian"
            }
        }
        
        var nextLevel: String {
            if let next = VIPLevel(rawValue: self.rawValue + 1) {
                switch next {
                case .none: return "None"
                case .bronze: return "Bronze"
                case .silver: return "Silver"
                case .gold: return "Gold"
                case .platinum: return "Platinum"
                case .diamond: return "Diamond"
                case .obsidian: return "Obsidian"
                }
            } else {
                return "Max"
            }
        }
        
        var color: Color {
            switch self {
            case .none: return .gray
            case .bronze: return Color(red: 205/255, green: 127/255, blue: 50/255)
            case .silver: return Color(red: 211/255, green: 211/255, blue: 211/255)
            case .gold: return .yellow
            case .platinum: return Color(red: 229/255, green: 228/255, blue: 226/255)
            case .diamond: return Color(red: 185/255, green: 242/255, blue: 255/255) 
            case .obsidian: return .black
            }
        }
        
        var nextLevelColor: Color {
            if let next = VIPLevel(rawValue: self.rawValue + 1) {
                switch next {
                case .none: return .gray
                case .bronze: return Color(red: 205/255, green: 127/255, blue: 50/255)
                case .silver: return Color(red: 211/255, green: 211/255, blue: 211/255)
                case .gold: return .yellow
                case .platinum: return Color(red: 229/255, green: 228/255, blue: 226/255)
                case .diamond: return Color(red: 185/255, green: 242/255, blue: 255/255)
                case .obsidian: return .black
                }
            } else {
                return .gray
            }
        }
    }
}
