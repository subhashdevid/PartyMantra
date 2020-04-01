//
//  EventListModel.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 31/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import DynamicCodable

struct EventListModel: Codable {
    var events: [Any]
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case events
        case image
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //        events = try values.decode([String: Any].self, forKey: .events)
        events = try values.decode([Any].self, forKey: .events)
        image = try values.decode(String.self, forKey: .image)
        
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //        try container.encode(events, forKey: .events)
        try container.encode(events, forKey: .events)
        try container.encode(image, forKey: .image)
     
    }
}

class EventCollectionlistModel {
    
    var id: Int?
    var creator_id: Int?
    var title: String?
    var startdate: String?
    var enddate: String?
    var description: String?
    var venue_name: String?
    var venue_adderss: String?
    var lat: Double?
    var lang: Double?
    var header_image: String?
    var small_image: String?
    var tnc: String?
    var custom_package_details: String?
    var priority: Int?
    var per_person_text: String?
    var time_to_start: String?
    
    
    var away: Int?
    var avgreviews: avgreviewsModel?
    var rating: String?
    
    // dining variable
    var name: String?
    var short_address: String?
    var collection_id: Int?
    
    init() {
        
    }
    convenience init(response: [String:Any]) {
        
        self.init()
        
        self.id = response["id"] as? Int
        self.creator_id = response["creator_id"] as? Int ?? 0
        self.title = response["title"] as? String
        self.rating = response["rating"] as? String
        self.startdate = response["startdate"] as? String
        self.enddate = response["enddate"] as? String
        self.description = response["description"] as? String
        self.venue_name = response["venue_name"] as? String
        self.venue_adderss = response["venue_adderss"] as? String
        self.lat = response["lat"] as? Double
        self.lang = response["lang"] as? Double
        
        self.header_image = response["header_image"] as? String
        self.small_image = response["small_image"] as? String
        self.tnc = response["tnc"] as? String
        self.custom_package_details = response["custom_package_details"] as? String
        self.priority = response["venue_adderss"] as? Int
        
        self.per_person_text = response["per_person_text"] as? String
        self.time_to_start = response["time_to_start"] as? String
        self.away = response["away"] as? Int
        
        self.collection_id = response["collection_id"] as? Int
        
        // dining variable
        self.name = response["name"] as? String
        self.short_address = response["short_address"] as? String
    }
    
}
