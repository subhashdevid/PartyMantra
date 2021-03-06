//
//  OrderReviewViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 03/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Cosmos
import UITextView_Placeholder


class OrderReviewViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var reviewTxtView: UITextView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var submitBtn: UIButton!
    
    var userRate =  0
    var comment = ""
    var orderId : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        rateView.rating = 0

        reviewTxtView.placeholder = "Write your comment"
        reviewTxtView.layer.borderWidth = 1
        reviewTxtView.layer.borderColor = UIColor.gray.cgColor
        
        rateView.didTouchCosmos = { rating in
            self.userRate = Int(rating)
        }
        
        self.submitBtn.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpTabBarAndNavigationTitle(tabBarHidden: true, navigationTitle: "Reviews")
    }
    
    
    func createUrl() -> String {
        var url = ""
        url = Server.shared.reviewOrderUrl + "/\(orderId ?? "")"
        return url
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        comment = textView.text
    }
    
    
    @objc func didTapSubmitButton()  {
        
        self.view.endEditing(true)
        
        if userRate > 0 && !comment.isEmpty {
            
            let param: [String: Any] = [
                "rating" : userRate ,
                "comment" : comment
            ]
            Loader.showHud()
            Multipart().formDataAPICall(mainView: self.view, urlString: createUrl(), parameter: param, handler: { (response, isSuccess) in
                
                Loader.dismissHud()
                if isSuccess{
                    let res = response as! Dictionary<String,Any>
                    
                    print(res)
                    let message = res["message"] ?? ""
                        self.showAlert(message as! String)
                }
            })
        }
        else{
            showAlert("Please enter comment and rate")
        }
    }
    
}
    
