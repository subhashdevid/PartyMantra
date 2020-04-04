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
        
        
        let reviewlistEndpoint: String = Server.shared.reviewListUrl + "\(reviewType)" + "/\(eventId ?? "")" + "/reviews"
        
        Alamofire.request(reviewlistEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let data = response.result.value{
                    print(data)
    
                    if  (data as? [[String : Any]]) != nil{
                        
                        for dict in data as? [String : Any] ?? [:] {
                            
                            print(dict)
                            
                        }
                        
                        
                        /*
                         "created_at" = "2020-03-02 13:45:10";
                         description = "chjfjk fhjj fjkg fjjjh djjf fjjgc fjj";
                         rating = 4;
                         user =         {
                             id = 18;
                             image = "http://partymantra.appoffice.xyz/uploads/users/1584616750518.png";
                             name = "pankaj kumar";
                         };
                         
                         **/
                        //let model = ReviewlisttModel.init(dict)
                        
                        //arry initialize
                        
                    //array.append(model)
                        //reload
                    }
                    
                    
                    
                    
                }
            }
    }
    
    
    /*
     
     class ReviewlisttModel {
         
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
     
     
     **/
    
    
    
    
}

