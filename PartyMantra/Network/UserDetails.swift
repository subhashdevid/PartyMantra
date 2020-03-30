//
//  UserDetails.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 30/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class UserDetails: NSObject {
  static let shared = UserDetails()
    private override init() { }
    
    //MARK: Set Details
    
    func set_address(_ address:String) -> Void {
        UserDefaults.standard.set(address, forKey: UserKeys.set_address_details.rawValue)
    }
    func set_address_lat(_ address:String) -> Void {
           UserDefaults.standard.set(address, forKey: UserKeys.set_address_lat.rawValue)
    }
    func set_address_long(_ address:String) -> Void {
           UserDefaults.standard.set(address, forKey: UserKeys.set_address_long.rawValue)
    }
     
   
    
    //MARK: Get Details
    func get_address_detail() -> String {
        if let address_detail = UserDefaults.standard.value(forKey: UserKeys.set_address_details.rawValue) as? String {
            return address_detail
        }
        return ""
    }
    func get_address_latitude() -> String {
        if let address_detail = UserDefaults.standard.value(forKey: UserKeys.set_address_lat.rawValue) as? String {
            return address_detail
        }
        return ""
    }
    func get_address_longitude() -> String {
        if let address_detail = UserDefaults.standard.value(forKey: UserKeys.set_address_long.rawValue) as? String {
            return address_detail
        }
        return ""
    }
    
    
    
    //MARK: Remove Details
    func Remove_address_details() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.set_address_details.rawValue)
        
    }
    func Remove_address_lat() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.set_address_lat.rawValue)
        
    }
    func Remove_address_long() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.set_address_long.rawValue)
        
    }
    
        

   
}

  
enum UserKeys:String {
        case set_address_details = "address_detail"
        case set_address_lat = "address_lat"
        case set_address_long = "address_long"
                   
       
        
   
}


