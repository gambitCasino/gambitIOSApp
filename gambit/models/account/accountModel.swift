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
    var fullName: String = ""
    var email: String = ""
    
    var firstName: String {
        return self.fullName.components(separatedBy: " ")[0]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode each property with a fallback default if the key is missing
        self._id = try container.decodeIfPresent(String.self, forKey: ._id) ?? ""
        self.appleId = try container.decodeIfPresent(String.self, forKey: .appleId) ?? ""
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
    }
    
    init() {}
        
    enum CodingKeys: String, CodingKey {
        case _id
        case appleId
        case fullName
        case email
    }
}
