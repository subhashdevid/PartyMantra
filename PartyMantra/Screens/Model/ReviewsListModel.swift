//
//  ReviewsListModel.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ReviewsListModel {
    var rating: Int?
    var description: String?
    var created_at: String?
    var user: UserModel?
    
    init() {
        
    }
    convenience init(response: [String:Any]) {
        
        self.init()
        self.rating = response["rating"] as? Int
        self.description = response["description"] as? String
        self.created_at = response["created_at"] as? String
        let userDict = response["user"] as? [String:Any] ?? [:]
        self.user = UserModel(response: userDict)
    }
}

class UserModel{
    var id: Int?
    var name: String?
    var image: String?
    
    init() {
        
    }
    convenience init(response: [String:Any]) {
        
        self.init()
        self.id = response["id"] as? Int
        self.name = response["name"] as? String
        self.image = response["image"] as? String

    }    
}
