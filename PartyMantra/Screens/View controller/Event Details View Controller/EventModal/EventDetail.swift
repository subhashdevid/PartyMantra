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
    var partner: EventPartnerDetailModal?
  //  var avgreviews: avgreviewsModel?
    var covers: [EventCoversDetailModal] = []
    var facilities: [EventFacilitiesDetailModal] = []
   // var packages: EventPackagesDetailModal?
    
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
        self.away = response["away"] as? Int
        
        self.partner = EventPartnerDetailModal.init(response: response["partner"] as? [String : Any] ?? [:])//
        let coverArr = response["covers"] as? [[String : Any]] ?? []
        let facilitiesArr = response["facilities"] as? [[String : Any]] ?? []
        for item in coverArr {
            self.covers.append(EventCoversDetailModal(response: item))
        }
        for item in facilitiesArr {
            self.facilities.append(EventFacilitiesDetailModal(response: item))
        }
    }
    
}

class EventPartnerDetailModal{

   var id: Int?
    var name: String?
    var description: String?
    var address: String?
    var short_address: String?
    var lat: Double?
    var lang: Double?
    var contact_no: String?
    var header_image: String?
    var small_image: String?
    var type: String?
    var per_person_text: String?
    var isactive: Bool?
    var open: String?
    var close: String?
    
    var allow_party: Bool?
    var priority: Int?
    var timings: String?
    var party_timings: String?
    var tnc: String?
    var discounts: String?
    var away: Int?
    
    
    init() {
        
    }
    convenience init(response: [String:Any]) {
    
        
        self.init()
        
        self.id = response["id"] as? Int
        self.name = response["name"] as? String
        self.description = response["description"] as? String
        self.address = response["address"] as? String
        self.short_address = response["short_address"] as? String
        self.contact_no = response["contact_no"] as? String
        self.header_image = response["header_image"] as? String

        self.small_image = response["small_image"] as? String
        self.type = response["type"] as? String
        self.per_person_text = response["per_person_text"] as? String
        self.isactive = response["isactive"] as? Bool
        self.open = response["open"] as? String
        self.lat = response["lat"] as? Double
        self.lang = response["lang"] as? Double

        self.allow_party = response["allow_party"] as? Bool
        self.priority = response["priority"] as? Int
        self.timings = response["timings"] as? String
        self.party_timings = response["party_timings"] as? String
        self.tnc = response["tnc"] as? String

        self.discounts = response["discounts"] as? String
        self.away = response["away"] as? Int
        

    }
       
}
struct EventAvgreviewsDetailModal: Codable {


}

class EventCoversDetailModal {

    var id: Int?
    var event_id: Int?
    var partner_id: Int?
    var package_name: String?
    var price : Int?
    var custom_package_detail : String?
    var text_under_name: String?
    var isactive: Bool?
    var partneractive: Int?
    var package_type: String?
    var fordining: Int?
    var forparty: Int?
    
    init() { }
    
    convenience init(response: [String:Any]) {
        self.init()
        
        self.id = response["id"] as? Int
        self.event_id = response["event_id"] as? Int
        self.partner_id = response["partner_id"] as? Int
        self.package_name = response["package_name"] as? String
        self.text_under_name = response["text_under_name"] as? String
        self.isactive = response["isactive"] as? Bool
        self.partneractive = response["partneractive"] as? Int
        self.price = response["price"] as? Int
        self.custom_package_detail = response["custom_package_detail"] as? String

        self.package_type = response["package_type"] as? String
        self.fordining = response["fordining"] as? Int
        self.forparty = response["forparty"] as? Int
        self.isactive = response["isactive"] as? Bool
     }
    
}

class EventFacilitiesDetailModal {
    var name: String?
    
    init() {}
       convenience init(response: [String:Any]) {
           self.init()
           self.name = response["name"] as? String
          

       }
}
//struct EventPackagesDetailModal: Codable {
//
//
//}


