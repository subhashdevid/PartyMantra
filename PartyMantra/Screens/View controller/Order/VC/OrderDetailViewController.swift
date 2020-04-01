//
//  OrderDetailViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 31/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseViewController {

    var orderId : String?
    var checkoutModel : OrderCheckoutModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchOrderDetails()
    }
    
    func createUrl() -> String {
       
        let accessUserToken =  UserDefaults.standard.string(forKey: "AccessToken")
               let param: [String: Any] = [
                   "token":accessUserToken ?? ""
               ]
      
        var url = ""
        if let orderId = orderId {
            url = Server.shared.orderDetailUrl + "/\(orderId)"
        }
        return url
    }
    
    func fetchOrderDetails() {
        Loader.showHud()
        
        let param: [String: Any] = [
            
            :]
        NetworkManager.getOrderDetails(url: createUrl(),parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                if let checkout = response.data {
                    self?.checkoutModel = checkout
                    print(self?.checkoutModel!)

//                    self?.tblView.reloadData()
                }
                
            case .failure: break
            }
        }
    }
    
    
}
