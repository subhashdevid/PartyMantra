//
//  EventDetail.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import DynamicCodable

struct EventDetailsModal: Codable {
    var event: [String: Any]
    enum CodingKeys: String, CodingKey {
        case event
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        event = try values.decode([String: Any].self, forKey: .event)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(event, forKey: .event)        
    }
}


class EventlistModel {
    
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
//    let partner: [EventPartnerDetailModal]?
//    let avgreviews: [avgreviewsModel]?
//    let covers: [EventCoversDetailModal]?
//    let facilities: [EventFacilitiesDetailModal]?
//    let packages: [EventPackagesDetailModal]?
    
    init() {
        
    }
    convenience init(response: [String:Any]) {
    
        
        self.init()
        
        self.id = response["id"] as? Int
        self.creator_id = response["creator_id"] as? Int ?? 0
        self.title = response["title"] as? String

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
        

    }
    
}

struct EventPartnerDetailModal: Codable {

   let id: Int?
    let name: String?
    let description: String?
    let address: String?
    let short_address: String?
    let lat: Double?
    let lang: Double?
    let contact_no: String?
    let header_image: String?
    let small_image: String?
    let type: String?
    let per_person_text: String?
    let isactive: Int?
    let open: String?
    let close: String?
    
    let allow_party: Int?
    let priority: Int?
    let timings: String?
    let party_timings: String?
    let tnc: String?
    let discounts: String?
    let away: Int?
       
}
struct EventAvgreviewsDetailModal: Codable {


}
struct EventCoversDetailModal: Codable {

    let id: Int?
    let event_id: Int?
    let partner_id: Int?
    let package_name: String?
    let text_under_name: String?
    let isactive: Int?
    let partneractive: Int?
    let package_type: String?
    let fordining: Int?
    let forparty: Int?
    
}
struct EventFacilitiesDetailModal: Codable {
    let name: String?

}
//struct EventPackagesDetailModal: Codable {
//
//
//}


