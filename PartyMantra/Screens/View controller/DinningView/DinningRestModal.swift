//
//  DinningRestModal.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 06/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class DinningRestModal: NSObject {

  
    
    
}

class DinningRestFacilitiesModal: NSObject {

    var name : String?
    
    convenience init(response: [String:Any]) {
           self.init()
           
           self.name = response["name"] as? String
        }
    
    
}
