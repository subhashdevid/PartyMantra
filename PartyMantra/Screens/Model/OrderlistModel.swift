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
    var order_date: String?
    var details : Array<OrderlistDetailsModel> = []


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
        self.order_date = response["order_date"] as? String
        let detail = response["details"] as? Array<Dictionary<String,AnyObject>> ?? []
        for item in detail {
            self.details.append(OrderlistDetailsModel(response: item))
        }
        
    }
    
}


    


class OrderlistDetailsModel {
    
    var id: Int?
    var partner_id: Int?
    var entity_id: Int?
    var price: Int?
    var no_of_pass: Int?
    var entity: listDetailsModel?
    var order_date: String?
   


    init() {
        
    }
    convenience init(response: [String:Any]) {
        
        self.init()
        
        self.id = response["id"] as? Int
        self.partner_id = response["partner_id"] as? Int
        self.entity_id = response["entity_id"] as? Int
        self.price = response["price"] as? Int
        self.no_of_pass = response["no_of_pass"] as? Int
        
        let entityDict = response["entity"] as? [String:AnyObject] ?? [:]
        
        self.entity =  listDetailsModel(response: entityDict)
        
        self.order_date = response["order_date"] as? String

    }
    
}


class listDetailsModel {
    
    var id: Int?
    var title: String?
    var startdate: String?
    var enddate: String?
    var venue_name: String?
    var venue_adderss: String?
    

    init() {
        
    }
    convenience init(response: [String:Any]?) {
        
        self.init()
        
        self.id = response?["id"] as? Int
        self.title = response?["title"] as? String ?? ""
        self.startdate = response?["startdate"] as? String
        self.enddate = response?["enddate"] as? String
        self.venue_name = response?["venue_name"] as? String
        self.venue_adderss = response?["venue_adderss"] as? String
       

    }
    
}





