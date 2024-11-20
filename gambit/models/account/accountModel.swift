//
//  accountModel.swift
//  node
//
//  Created by Nick Mantini on 10/30/24.
//

import Foundation

struct AccountModel: Codable {
    var _id: String = ""
    var appleId: String = ""
    var username: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var vipProgress: Float = 0.0
    var bits: Float = 0.0
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
        self.vipProgress = try container.decodeIfPresent(Float.self, forKey: .vipProgress) ?? 0.0
        self.bits = try container.decodeIfPresent(Float.self, forKey: .bits) ?? 0.0
        
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
        case vipProgress
        case bits
        case createdAt
        case isVerified
    }
}
