//
//  Constants.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 19/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    class var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    /*
    class var userID : String {
        var userId: String = ""
        if let savedUser = UserDefaults.standard.object(forKey: "USER") as? Data {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: savedUser) {
                userId = "\(user.userid)"
                
            }
        }
        return userId
    }
 */
    
    class var windowWidth: CGFloat {
        if let rootwindow = UIApplication.shared.delegate?.window, let view = rootwindow!.rootViewController?.view {
            return view.bounds.size.width
        }
        return 0
    }

    class var windowHeigth: CGFloat {
        if let rootwindow = UIApplication.shared.delegate?.window, let view = rootwindow!.rootViewController?.view {
            return view.bounds.size.height
        }
        return 0
    }
    
    class var defaultUserImage: UIImage {
        return UIImage.init(named: "DefaultImage")!
    }
    
//    class var user: User {
//        if let savedUser = UserDefaults.standard.object(forKey: "USER") as? Data {
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: savedUser) {
//                return user
//            }
//        }
//    }
    
    
   
    
}
