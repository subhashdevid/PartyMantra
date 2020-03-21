//
//  EventDetailsViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController  {
    @IBOutlet weak var tblView: UITableView!
    
    var eventModel: eventModel?
    var type: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.estimatedRowHeight = 44
        fetchEventDetail()
    }
    
    func createUrl() -> String {
        var url = ""
        if let eventId = eventModel?.id {
            url = Server.shared.eventsUrl + "/\(eventId)/" + "\(type ?? "")"
        }
        return url
    }

    func fetchEventDetail() {
        
        let param: [String: Any] = [:]
        Loader.showHud()
        NetworkManager.getEventDetailListing(url: createUrl(),parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                if let events = response.data {
                    let eventList = EventlistModel.init(response: events.event)
                    print(eventList.title ?? "")
                }
                
            case .failure: break
            }
        }
        
    }


    
    
}









extension EventDetailsViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tblView.dequeueReusableCell(withIdentifier: "GalleryViewCell")
        
        if indexPath.section == 0 {
            let cell =  tblView.dequeueReusableCell(withIdentifier: "GalleryViewCell")
            
            return cell!
        }
        else  if indexPath.section == 1 {
            let cell =  tblView.dequeueReusableCell(withIdentifier: "AddressViewCell")
            return cell!
        }
        else  if indexPath.section == 1 {
            let cell =  tblView.dequeueReusableCell(withIdentifier: "AddressViewCell")
            return cell!
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
