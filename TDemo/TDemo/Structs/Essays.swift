//
//  Essays.swift
//  TDemo
//
//  Created by Virpik on 09/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation

struct Essays: Codable {
    var essays: [Essay] = []
}

struct Essay {
    var id: Int
    var dateAt: Date
    var title: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case dateAt = "date_at"
        case title
        case body
    }
}

extension Essay: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.dateAt.timeIntervalSince1970, forKey: .dateAt)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.body, forKey: .body)
    }
}

extension Essay: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.body = try values.decode(String.self, forKey: .body)

        let dateAtTimeInterval = try values.decode(Double.self, forKey: .dateAt)
        
        self.dateAt = Date(timeIntervalSince1970: dateAtTimeInterval)
    }
}
