//
//  ReviewsViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 03/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    var eventId : String?
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  createUrl()
        }
    
    func createUrl() -> String {
        let url = Server.shared.reviewListUrl + (type ?? "") + (eventId ?? "") + "reviews"
        return url
    }
    
            }
        
    
    

