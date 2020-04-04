//
//  ReviewsViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 03/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Alamofire

class ReviewsViewController: UIViewController {
    var reviewData : [ReviewsListModel] = []
    
    var eventId : String?
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reviewlistEndpointCall()
    }
    
    
    func reviewlistEndpointCall()  {
        
        var reviewType = ""
        if self.type == "events"{
            reviewType = "event"
        }
        else  if self.type == "party"{
            reviewType = "party"
        }
        else {
        }
        Loader.showHud()
        let reviewlistEndpoint: String = Server.shared.reviewListUrl + "\(reviewType)" + "/\(eventId ?? "")" + "/reviews"
        Alamofire.request(reviewlistEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let data = response.result.value{
                    //print(data)
                    Loader.dismissHud()
                    if  (data as? [[String : Any]]) != nil{
                        for dict in data as? [[String : Any]] ?? [[:]] {
                            print(dict)
                            let model = ReviewsListModel.init(response: dict)
                            self.reviewData.append(model)
                        }
                        
                        //reload
                    }
                }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

