//
//  Server.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 19/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import UIKit
//
enum ServerEnvironment {
    
    case live, staging, QA
    // Main Server
    var baseURL: String {
        switch self {
        case .QA:
            return "http://partymantra.appoffice.xyz"
        case .staging:
            return "http://partymantra.appoffice.xyz"
        case .live:
            return "http://partymantra.appoffice.xyz"
        }
    }
    
}

// AIP 2 // get date and get setting//

let currentEnvironment: ServerEnvironment = .staging  //Checkpoint

/// Server base URL string.
public let kBaseURL = currentEnvironment.baseURL

let mainUrl = "\(kBaseURL)/api/"

class Server: NSObject, Codable { // checkpoint
    
    
//    fileprivate var operationQueue = OperationQueue()

    

    static let shared = Server()
    fileprivate var timeInterval = Date().timeIntervalSince1970
    
    

    var LoginUrl = "\(mainUrl)login"
    
    var VerifyUrl = "\(mainUrl)verify-otp"
    
    var HomeUrl = "\(mainUrl)home"
    
    var collectionUrl = "\(mainUrl)collections"
    
    var collectionDetailUrl = "\(mainUrl)collection"
    
    var getWalletBalanceUrl = "\(mainUrl)wallet-balance"
    var getWalletHistoryUrl = "\(mainUrl)wallet-history"
    
    
    
    var getOrderUrl = "\(mainUrl)order-history"
    
    
    var NotificationUrl = "\(mainUrl)notifications"
//
//
//    var HomepageUrl = "\(mainUrl)gethomecategory"
//
//    var MobileProductUrl = "\(mainUrl)getproduct_brand"
//    var TabProductUrl = "\(mainUrl)getproduct_brand_tablet"
//
//    var PriceBasedUrl = "\(mainUrl)getfilter_price"
//    var ProductImageUrl = "\(mainUrl)getmobile_image"
//
//    var getProfileUrl = "\(mainUrl)getprofile"
//    var updateProfileUrl = "\(mainUrl)updateprofile"
//
//    var repairRequireUrl = "\(mainUrl)requirement"
//
//    var resendOTP = "http://api.msg91.com/api/sendhttp.php"
    
    var serverTimeInterval: TimeInterval = Date().timeIntervalSince1970
    

    
    override init() {}
    
    required init(from _: Decoder) throws {}

}
