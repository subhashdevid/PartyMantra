//
//  OrderlistModel.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 31/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import DynamicCodable

struct OrderlistModel: Codable {
    var ordersdetail: [Any]
    var cancel_reasons: [String : Any]
    
    
    enum CodingKeys: String, CodingKey {
        case ordersdetail
        case cancel_reasons
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ordersdetail = try values.decode([Any].self, forKey: .ordersdetail)
        cancel_reasons = try values.decode([String:Any].self, forKey: .cancel_reasons)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(ordersdetail, forKey: .ordersdetail)
        try container.encode(cancel_reasons, forKey: .cancel_reasons)
    }
}


class OrderDetaillistModel {
    
    var id: Int?
    var refid: String?
    var title: String?
    var updated_at: String?
    var payment_status: String?
    var total: Int?
    var ordertype: String?
    var image: String?


    init() {
        
    }
    convenience init(response: [String:Any]) {
        
        self.init()
        
        self.id = response["id"] as? Int
        self.refid = response["refid"] as? String ?? ""
        self.title = response["title"] as? String
        self.updated_at = response["updated_at"] as? String
        self.payment_status = response["payment_status"] as? String
        self.total = response["total"] as? Int
        self.ordertype = response["ordertype"] as? String
        self.image = response["image"] as? String

    }
    
}
