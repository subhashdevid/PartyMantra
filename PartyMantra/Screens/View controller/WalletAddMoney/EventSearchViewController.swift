//
//  EventSearchViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class EventSearchViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    var searchedString : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchSearchedEventDetail()
    }
        
    func fetchSearchedEventDetail() {
        let param: [String: Any] = [
            "search" : searchedString ?? ""
        ]
        Loader.showHud()
        NetworkManager.getSearchListing(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                if let notification = response.data {
                   print(notification)
                }
                
            case .failure:
                Loader.dismissHud()
                break
            }
        }
    }
    
    
}


extension EventSearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "CustomTableViewCell")
        return cell!
    }
}
