//
//  ReviewListModel.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import DynamicCodable

class ReviewListModel{
    
    
    var rating: Int?
    var description: String?
    var created_at: String?
    var user: userDetailsModel?
    
    
    
    init() {
        
    }
    convenience init(response: [String:Any]) {
        
        self.init()
    
        self.rating = response["rating"] as? Int
        self.description = response["description"] as? String ?? ""
        self.created_at = response["created_at"] as? String ?? ""
        
        let userDict = response["user"] as? [String:Any] ?? [:]
        
        self.user =  userDetailsModel(response: userDict)
        
        
        
        
    }
    
}

class userDetailsModel {
    
    var id: Int?
    var name: String?
    var image: String?
    

    init() {
        
    }
    convenience init(response: [String:Any]?) {
        
        self.init()
        
        self.id = response?["id"] as? Int
        self.name = response?["name"] as? String ?? ""
        self.image = response?["image"] as? String
        
       

    }
    
}

/*
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
 */


