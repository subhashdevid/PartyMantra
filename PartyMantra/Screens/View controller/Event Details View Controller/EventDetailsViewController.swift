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
    var eventData : [EventlistModel] = []
    
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
                    self?.eventData = [EventlistModel(response: events.event)]
                   // print(self?.eventData[0].event ?? nil)
                    self?.tblView.reloadData()
                }
            case .failure: break
            }
        }
    }
}



// MARK: Table view Delegate

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
            let cell : GalleryViewCell =  tblView.dequeueReusableCell(withIdentifier: "GalleryViewCell") as! GalleryViewCell
            
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                print(cellModal)
                cell.configureGallaryView(modal: cellModal)
            }
            
            return cell
        }
        else  if indexPath.section == 1 {
            let cell : AddressViewCell =  tblView.dequeueReusableCell(withIdentifier: "AddressViewCell") as! AddressViewCell
           
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                print(cellModal)
                cell.configureAddressCell(modal: cellModal)
            }
            return cell
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
