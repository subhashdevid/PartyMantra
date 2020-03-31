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
        
        self.tblView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getCollectionClubDetailList()
    }
    
    func createUrl() -> String {
        let param: [String: Any] = [
            :]
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
        cell?.bannerimgView.kf.setImage(with: URL(string: imgUrl ), placeholder: nil)
        
        if indexPath.section == 1 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "custom") as? CustomTableViewCell
            let model = self.eventCollectionData[indexPath.row]
            cell?.titleLbl.text = model.title
            cell?.subtitleLbl.text = model.venue_name
            cell?.addressLbl.text = model.venue_adderss
            cell?.priceLbl.text = model.per_person_text
            cell?.dateLbl.text = model.startdate
            
            let url = URL(string: model.small_image ?? "")
            cell?.bannerimgView.contentMode = .scaleAspectFill
            cell?.bannerimgView.kf.setImage(with: url, placeholder: nil)
            
            return cell!
        }
        return cell!
        
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let model = self.eventCollectionData[indexPath.row]
           
           let vc = EventDetailsViewController.instantiate(appStoryboard: .events) as EventDetailsViewController
           vc.eventID = model.id ?? 0
           self.navigationController?.pushViewController(vc, animated: true)
           
       }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }
        return UITableView.automaticDimension
    }
    
}
