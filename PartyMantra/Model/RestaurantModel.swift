//
//  RestaurantModel.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 07/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import DynamicCodable

struct Restaurant: Codable {
    var restaurant: [String: Any]
    
    enum CodingKeys: String, CodingKey {
        case restaurant
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurant = try values.decode([String: Any].self, forKey: .restaurant)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(restaurant, forKey: .restaurant)
    }
}


class RestaurantInfoModel {
    
    var id: Int?
    var name: String?
    var description: String?
    var address: String?
    var short_address: String?
    var lat: String?
    var lang: String?
    var contact_no: String?
    var header_image: String?
    var small_image: String?
    var type: String?
    var per_person_text: String?
    var isactive: Int?
    var open: String?
    var close: String?
    var allow_party: Int?
    var priority: Int?
    var timings: String?
    
    var party_timings: String?
    var tnc: String?
    var rating: Int?
    var discounts: String?
    var away:Int?
    
    var eventparty : [RestaurantEventparty] = []
    var avgreviews: [RestaurantAvgReviewsModel] = []
    var facilities: [RestaurantInfoFacilities] = []
    var menus: [RestaurantMenuList] = []
    var packages: [EventPackagesDetailModal] = []
    
    
    
    
    
    init() {
    }
    convenience init(response: [String:Any]) {
        
        self.init()
        
        self.id = response["id"] as? Int
        self.name = response["name"] as? String ?? ""
        self.description = response["description"] as? String
        self.address = response["address"] as? String
        self.short_address = response["short_address"] as? String
        self.lat = response["lat"] as? String
        self.lang = response["lang"] as? String
        self.contact_no = response["contact_no"] as? String
        self.header_image = response["header_image"] as? String ?? ""
        self.small_image = response["small_image"] as? String
        self.type = response["type"] as? String
        self.per_person_text = response["per_person_text"] as? String
        self.isactive = response["isactive"] as? Int
        
        
        self.open = response["open"] as? String
        self.close = response["close"] as? String
        self.allow_party = response["isactive"] as? Int
        self.priority = response["isactive"] as? Int
        
        self.timings = response["timings"] as? String
        self.party_timings = response["party_timings"] as? String
        self.tnc = response["tnc"] as? String
        self.rating = response["rating"] as? Int
        self.discounts = response["discounts"] as? String
        self.away = response["away"] as? Int
        
        
        
        let eventpartyArr = response["eventparty"] as? [[String : Any]] ?? []
        let facilitiesArr = response["facilities"] as? [[String : Any]] ?? []
        let menusArr = response["menus"] as? [[String : Any]] ?? []
        let reviewArr = response["avgreviews"] as? [[String : Any]] ?? []
        let packageArr = response["packages"] as? [[String : Any]] ?? []
        
        
        for item in eventpartyArr {
            self.eventparty.append(RestaurantEventparty(response: item))
        }
        for item in facilitiesArr {
            self.facilities.append(RestaurantInfoFacilities(response: item))
        }
        for item in packageArr {
            self.packages.append(EventPackagesDetailModal(response: item))
        }
        
        for item in reviewArr {
            self.avgreviews.append(RestaurantAvgReviewsModel(response: item))
        }
        
        for item in menusArr {
            self.menus.append(RestaurantMenuList(response: item))
        }
        
    }
    
}

class RestaurantInfoFacilities {
    var name: String?
    
    init() {
    }
    convenience init(response: [String:Any]) {
        self.init()
        self.name = response["name"] as? String ?? ""
    }
}

class RestaurantEventparty {
    var other_type: String?
    var other_id: Int?
    var doc_path: String?
    var updated_at: String?
    init() {
    }
    convenience init(response: [String:Any]) {
        self.init()
        self.other_type = response["other_type"] as? String ?? ""
        self.other_id = response["other_id"] as? Int ?? 0
        self.doc_path = response["doc_path"] as? String ?? ""
        self.updated_at = response["updated_at"] as? String ?? ""
    }
}

class RestaurantAvgReviewsModel {
    var rating: String?
    var reviews: Int?
    
    init() {
    }
    convenience init(response: [String:Any]) {
        self.init()
        self.rating = response["rating"] as? String ?? ""
        self.reviews = response["reviews"] as? Int ?? 0
        
    }
}


class RestaurantMenuList{
    
    var id: Int?
    var name: String?
    var image: String?
    var price: Int?
    var cut_pice: Int?
    var category_id: Int?
    var description: String?
    var partneractive: Int?
    var creator_id: Int?
    var partner_id: Int?
    
    var itemCount: Int?
    var pivot: RestaurantMenuPivot?
    
    
    init() {
    }
    
    convenience init(response: [String:Any]) {
        self.init()
        self.id = response["id"] as? Int ?? 0
        self.name = response["name"] as? String ?? ""
        self.image = response["image"] as? String ?? ""
        self.price = response["price"] as? Int ?? 0
        self.cut_pice = response["cut_pice"] as? Int ?? 0
        self.category_id = response["category_id"] as? Int ?? 0
        self.description = response["description"] as? String ?? ""
        self.partneractive = response["partneractive"] as? Int ?? 0
        self.creator_id = response["creator_id"] as? Int ?? 0
        self.partner_id = response["partner_id"] as? Int ?? 0
        
        
        let restpiv = response["pivot"] as? [String : Any]
        self.pivot = RestaurantMenuPivot.init(response: restpiv ?? [:])
        
        
        
    }
}

class RestaurantMenuPivot {
    var partner_id: Int?
    var menu_id: Int?
    var price: Int?
    var cut_price: Int?
    
    init() {
    }
    convenience init(response: [String:Any]) {
        self.init()
        self.partner_id = response["partner_id"] as? Int ?? 0
        self.menu_id = response["menu_id"] as? Int ?? 0
        self.price = response["price"] as? Int ?? 0
        self.cut_price = response["cut_price"] as? Int ?? 0
    }
}


