//
//  SearchEventModel.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 23/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import DynamicCodable



struct SearchEventModel: Codable {
        var eventSearchArray: [Any]

    
    enum CodingKeys: String, CodingKey {
        case array
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        eventSearchArray = try values.decode([Any].self, forKey: .array)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
 try container.encode(eventSearchArray, forKey: .array)    }
}
