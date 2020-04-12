//
//  EventListViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 31/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    
    var type: String?
    var collectionID : Int?
    var eventCollectionData : [EventCollectionlistModel] = []
    var imgUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        self.tblView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getCollectionClubDetailList()
    }
    
    func createUrl() -> String {
        var param: [String: Any] = [
                   "lat" : UserDetails.shared.get_address_latitude(),
                   "lang": UserDetails.shared.get_address_longitude()
               ]
        var url = ""
        if let collectionID = collectionID {
            url = Server.shared.collectionDetailUrl + "/\(collectionID)/" + "\(type ?? "")"
        }
        return url
    }
    
    func getCollectionClubDetailList() {
        Loader.showHud()
        
        let param: [String: Any] = [
            
            :]
        NetworkManager.getCollectionEventListing(url: createUrl(),parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                if let eventlist = response.data {
                    self?.imgUrl = eventlist.image
                    self?.eventCollectionData.removeAll()
                    for dict in eventlist.events {
                        let model = EventCollectionlistModel.init(response: dict as? [String:Any] ?? [:])
                        self?.eventCollectionData.append(model)
                    }
                    self?.tblView.reloadData()
                }
                
            case .failure: break
            }
        }
    }
    
    
    
    
    
    //MARK: Table view delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0{
            return self.eventCollectionData.count // array.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "imgCell") as? CustomTableViewCell
        cell?.bannerimgView.kf.setImage(with: URL(string: imgUrl ), placeholder: UIImage(named: "applogo_1024"))
        cell?.bannerimgView.contentMode = .scaleAspectFill
        
        if indexPath.section == 1 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "custom") as? CustomTableViewCell
            let model = self.eventCollectionData[indexPath.row]
            cell?.titleLbl.text = model.title
            cell?.subtitleLbl.text = model.venue_name
            cell?.addressLbl.text = model.venue_adderss
            cell?.priceLbl.text = model.per_person_text
            cell?.dateLbl.text = model.startdate
            cell?.distanceLbl.text = NSString(format:"%d", model.away ?? "0") as String + " Km away"
            
            cell?.startLbl.text = model.time_to_start
            //cell?.ratingLbl.text=model.rating
            let url = URL(string: model.small_image ?? "")
            cell?.bannerimgView.contentMode = .scaleAspectFill
            cell?.bannerimgView.kf.setImage(with: url, placeholder: UIImage(named: "applogo_1024"))
            
            if type == "restaurants" || type == "party" {
                cell?.titleLbl.text = model.name
                        cell?.subtitleLbl.text = model.short_address
            }
            
            return cell!
        }
        return cell!
        
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let model = self.eventCollectionData[indexPath.row]
           if type == "restaurants"{
            let vc = RestaurentViewController.instantiate(appStoryboard: .dinning) as RestaurentViewController
            vc.eventID = model.id ?? 0
            
            vc.type = self.type
            self.navigationController?.pushViewController(vc, animated: true)
           }else {
            let vc = EventDetailsViewController.instantiate(appStoryboard: .events) as EventDetailsViewController
             vc.eventID = model.id ?? 0
             
             vc.type = self.type
             self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }
        if indexPath.section == 1 {
            return 120
        }
        return UITableView.automaticDimension
    }
    
}
