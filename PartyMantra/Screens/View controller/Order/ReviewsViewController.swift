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
    //var reviewModel : ReviewsListModel?
    
    var eventId : String?
    var type: String?
    
    @IBOutlet weak var reviewTableview: UITableView!
    @IBOutlet weak var reviewLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reviewLbl.isHidden = true
        reviewTableview.isHidden = true
        self.reviewlistEndpointCall()
    }
    
    
    func reviewlistEndpointCall()  {
        
        var reviewType = ""
        if self.type == "events"{
            reviewType = "event"
        }
        else if self.type == "restaurant"{
            reviewType = "restaurant"
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
                    print(data)
                    Loader.dismissHud()
                    if  (data as? [[String : Any]]) != nil{
                        self.reviewData.removeAll()
                        for dict in data as? [[String : Any]] ?? [[:]] {
                            print(dict)
                            let model = ReviewsListModel.init(response: dict)
                            self.reviewData.append(model)
                        }
                        
                        if self.reviewData.count > 0 {
                            self.reviewLbl.isHidden = true
                            self.reviewTableview.isHidden = false
                            
                        }else{
                            self.reviewLbl.isHidden = false
                            self.reviewTableview.isHidden = true
                        }
                        
                        self.reviewTableview.reloadData()
                        
                    }
                }
                
        }
    }
}

extension ReviewsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.reviewTableview.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell
        let modelobj = self.reviewData[indexPath.row]
        
        cell?.configureReviewCell(reviewModal: modelobj)
        return cell!
    }
}


