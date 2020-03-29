//
//  EventDetailsViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController,GetFinalHeightOfCell  {
    
    
    
    @IBOutlet weak var tblView: UITableView!

    var heightOfCell : Int = 0
    var heightindex = 0
    var cellHeight = 0
    var isCellClicked : Bool = false
    var eventID : Int = 0
    var eventData : [EventlistModel] = []
    
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.estimatedRowHeight = 44
        tblView.separatorStyle = .none
        fetchEventDetail()
    }
    
    func createUrl() -> String {
        let url = Server.shared.eventsUrl + "/\(eventID)/" + "\(type ?? "")"
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
   
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 1
        
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
        else  if indexPath.section == 2 {
           var cell: MoreInfoTableViewCell! = tblView.dequeueReusableCell(withIdentifier: "MoreInfoTableViewCell") as? MoreInfoTableViewCell
            if cell == nil {
                tblView.register(UINib(nibName: "MoreInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreInfoTableViewCell")
                cell = tblView.dequeueReusableCell(withIdentifier: "MoreInfoTableViewCell") as? MoreInfoTableViewCell
            }
          
            cell.backgroundColor = .groupTableViewBackground
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                print(cellModal)
                cell.configureMoreInfoCell(modal:cellModal)
            }
           return cell
        }
        else  if indexPath.section == 3 {
           var cell: EventDescTableViewCell! = tblView.dequeueReusableCell(withIdentifier: "EventDescTableViewCell") as? EventDescTableViewCell
            if cell == nil {
                tblView.register(UINib(nibName: "EventDescTableViewCell", bundle: nil), forCellReuseIdentifier: "EventDescTableViewCell")
                cell = tblView.dequeueReusableCell(withIdentifier: "EventDescTableViewCell") as? EventDescTableViewCell
            }
          cell.backgroundColor = .groupTableViewBackground
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                print(cellModal)
                cell.configureCellEventDescView(modal:cellModal)
            }
           return cell
        }
        else  if indexPath.section == 4 {
           var cell: CoverChargesTableViewCell! = tblView.dequeueReusableCell(withIdentifier: "CoverChargesTableViewCell") as? CoverChargesTableViewCell
            if cell == nil {
                tblView.register(UINib(nibName: "CoverChargesTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverChargesTableViewCell")
                cell = tblView.dequeueReusableCell(withIdentifier: "CoverChargesTableViewCell") as? CoverChargesTableViewCell
            }
          cell.backgroundColor = .groupTableViewBackground
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                print(cellModal)
                cell.configureMoreInfoCell(modal:cellModal)
            }
           return cell
        } else  if indexPath.section == 5 {
                  var cell: PackagesTableViewCell! = tblView.dequeueReusableCell(withIdentifier: "PackagesTableViewCell") as? PackagesTableViewCell
                   if cell == nil {
                       tblView.register(UINib(nibName: "PackagesTableViewCell", bundle: nil), forCellReuseIdentifier: "PackagesTableViewCell")
                       cell = tblView.dequeueReusableCell(withIdentifier: "PackagesTableViewCell") as? PackagesTableViewCell
                   }
            cell.heightDelegate = self
                 cell.backgroundColor = .groupTableViewBackground
                   if self.eventData.count > 0 {
                       let cellModal = self.eventData[0] as EventlistModel
                       print(cellModal)
                       
                       cell.configurePackageCell(modal:cellModal)
                   }
                  return cell
        }else if indexPath.section == 6{
           var cell: EnterContactDetailsTableViewCell! = tblView.dequeueReusableCell(withIdentifier: "EnterContactDetailsTableViewCell") as? EnterContactDetailsTableViewCell
            if cell == nil {
                tblView.register(UINib(nibName: "EnterContactDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "EnterContactDetailsTableViewCell")
                cell = tblView.dequeueReusableCell(withIdentifier: "EnterContactDetailsTableViewCell") as? EnterContactDetailsTableViewCell
            }
          cell.backgroundColor = .groupTableViewBackground
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                print(cellModal)
                //cell.configureMoreInfoCell(modal:cellModal)
            }
           return cell
        }else if indexPath.section == 7{
           var cell: TermsAndConditionTableViewCell! = tblView.dequeueReusableCell(withIdentifier: "TermsAndConditionTableViewCell") as? TermsAndConditionTableViewCell
            if cell == nil {
                tblView.register(UINib(nibName: "TermsAndConditionTableViewCell", bundle: nil), forCellReuseIdentifier: "TermsAndConditionTableViewCell")
                cell = tblView.dequeueReusableCell(withIdentifier: "TermsAndConditionTableViewCell") as? TermsAndConditionTableViewCell
            }
          cell.backgroundColor = .groupTableViewBackground
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                print(cellModal)
                if self.isCellClicked{
                    cell.termsAndConditionStr.text = cellModal.tnc
                }else{
                    cell.termsAndConditionStr.text = ""
                }
                
                //cell.configureMoreInfoCell(modal:cellModal)
            }
           return cell
        }else if indexPath.section == 8{
           var cell: SubmitBtnTableViewCell! = tblView.dequeueReusableCell(withIdentifier: "SubmitBtnTableViewCell") as? SubmitBtnTableViewCell
            if cell == nil {
                tblView.register(UINib(nibName: "SubmitBtnTableViewCell", bundle: nil), forCellReuseIdentifier: "SubmitBtnTableViewCell")
                cell = tblView.dequeueReusableCell(withIdentifier: "SubmitBtnTableViewCell") as? SubmitBtnTableViewCell
            }
             cell.backgroundColor = .groupTableViewBackground
             cell.submitCellBtn.addTarget(self, action: #selector(didTapToOpenEventCart), for: .touchUpInside)
           return cell
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                return (CGFloat(cellModal.facilities.count*30+40))
            }
            return 0
        }else if indexPath.section == 4{
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                return (CGFloat(cellModal.covers.count*45+40))
            }
            return 0
        }else if indexPath.section == 5{
            if self.eventData.count > 0 && self.heightOfCell>0 && self.heightindex == indexPath.row{
                print(self.heightOfCell)
                return CGFloat(self.heightOfCell)
                
            }else if self.eventData.count > 0 && self.heightOfCell>0 && self.heightindex == 1{
                print(self.heightOfCell)
                               return CGFloat(self.heightOfCell)
            }else{
                if self.eventData.count > 0{
                let cellModal = self.eventData[0].packages as [EventPackagesDetailModal]
                let height = Int(((cellModal.count)*(139))+60)
                   
                    return CGFloat(height)
                }
               
            }
            
            return 0
        }else if indexPath.section == 6{
             return UITableView.automaticDimension
        }else if indexPath.section == 7{
            if self.isCellClicked{
                return UITableView.automaticDimension
            }else{
                return 50
            }
           
        }
            return UITableView.automaticDimension
    }
    
    //50
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 7{
            self.isCellClicked = !self.isCellClicked
            self.tblView.reloadData()
        }
    }
    
    
    func getHeightFromArr(height:Int,restCellHeight:Int,isViewMoreBtnClicked:Bool,indexInt:Int) {
        self.heightindex = indexInt
        if self.eventData.count > 0{
        let cellModal = self.eventData[0].packages as [EventPackagesDetailModal]
        if isViewMoreBtnClicked {
            self.heightOfCell = Int(125+height)
            print(self.heightOfCell)
            self.tblView.reloadData()
        }else{
           self.heightOfCell = Int(((cellModal.count)*(145))+50)
           self.tblView.reloadData()
        }
        }
    }
    
    
    @objc func didTapToOpenEventCart(sender:UIButton) -> Void {
        let vc = EventCartViewController.instantiate(appStoryboard: .events) as EventCartViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

