//
//  EventDetailsViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import EzPopup
class EventDetailsViewController: BaseViewController,GetFinalHeightOfCell  {
    
    enum FieldIdentifier: Int {
        case name = 0
        case email = 1
        case mobile = 2
    }

    
    @IBOutlet weak var tblView: UITableView!

    var heightOfCell : Int = 0
    var heightindex = 0
    var cellHeight = 0
    var isCellClicked : Bool = false
    var eventID : Int = 0
    var eventData : [EventlistModel] = []
    var type: String?
    var emailString : String?
    var nameString : String?
    var mobileString : String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    var validation = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.estimatedRowHeight = 44
        tblView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {

        //self.setUpTabBarAndNavigationTitle(tabBarHidden: true, navigationTitle: "Event Details")
        if self.type == "party" {
            self.setUpTabBarAndNavigationTitle(tabBarHidden: true, navigationTitle: "Party Details")
            fetchPartyDetail()
        }else{
            self.setUpTabBarAndNavigationTitle(tabBarHidden: true, navigationTitle: "Event Details")
            fetchEventDetail()
        }

    }
   
    func createUrl() -> String {
        let url = Server.shared.eventsUrl + "/\(eventID)"
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
    
    //MARK:- Party details API
    
    func createPartyUrl() -> String {
        let url = Server.shared.partyUrl + "/\(eventID)"
        return url
    }
    
    func fetchPartyDetail() {
        
        let param: [String: Any] = [:]
        Loader.showHud()
        NetworkManager.getPartyDetailListing(url: createPartyUrl(),parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                if let events = response.data {
                    self?.eventData = [EventlistModel(response: events.party)]
                    // print(self?.eventData[0].event ?? nil)
                    self?.tblView.reloadData()
                }
            case .failure: break
            }
        }
    }
    
    
    
    
    
    func addCoverBtn()  {
        
    }
    
    func minusCoverBtn()  {
        
    }
    
    
}

extension EventDetailsViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if FieldIdentifier.name.rawValue == textField.tag {

            return true
               }
               else if FieldIdentifier.email.rawValue == textField.tag {
                   return true
               }
               else if FieldIdentifier.mobile.rawValue == textField.tag {
                   return true
               }
        return true

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if FieldIdentifier.mobile.rawValue == textField.tag {

            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            
            if length == 0 {
                return false
            }
            
            let hasLeadingOne = length > 0 && decimalString.hasPrefix("1")
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int

                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()

            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 3 {
                let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@ ", areaCode)
                index += 3
            }
            if length - index > 3 {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        }
        else {
            return true
        }
    }
    
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if FieldIdentifier.name.rawValue == textField.tag {
            nameString = textField.text
            
        }
        else if FieldIdentifier.email.rawValue == textField.tag {
            emailString = textField.text
        }
        else if FieldIdentifier.mobile.rawValue == textField.tag {
            mobileString = textField.text
        }
        
        
    }
    @objc func didtapCall(sender : UIButton?) {

        let model = self.eventData[0] as EventlistModel
        self.callNumber(phoneNo: model.contact_no ?? "")
    }
    
    @objc func didtapDirection(sender : UIButton?) {
        let model = self.eventData[0] as EventlistModel
        self.openMapForRedirection(lat: model.lat ?? "0.0", long:  model.lat ?? "0.0")
          
       }
       
       func callNumber(phoneNo : String){
           appDelegate.callNumber(phoneNumber: phoneNo)
       }
      
    
    @objc func didtapReviewOrder(sender : UIButton?) {
        
        if self.eventData.count > 0 {
            let model = self.eventData[0] as EventlistModel
            let vc = ReviewsViewController.instantiate(appStoryboard: .miscellaneous) as ReviewsViewController
            
            vc.eventId = "\(model.id ?? 0)"
            vc.type = self.type
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didtapOnGalleryBtn(sender : UIButton?) {
        if self.eventData.count > 0 {
            let model = self.eventData[0] as EventlistModel
            let vc = GalleryViewController.instantiate(appStoryboard: .miscellaneous) as GalleryViewController
            vc.eventId = "\(model.id ?? 0)"
            vc.type = self.type
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

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
            
            cell.reviewbtn.addTarget(self, action: #selector(didtapReviewOrder(sender:)), for: .touchUpInside)
            cell.gallerybtn.addTarget(self, action: #selector(didtapOnGalleryBtn(sender:)), for: .touchUpInside)

            
            
            
            return cell
        }
        else  if indexPath.section == 1 {
            let cell : AddressViewCell =  tblView.dequeueReusableCell(withIdentifier: "AddressViewCell") as! AddressViewCell
           
            if self.eventData.count > 0 {
                let cellModal = self.eventData[0] as EventlistModel
                print(cellModal)
                cell.configureAddressCell(modal: cellModal)
                cell.clickToCallBtn.addTarget(self, action: #selector(didtapCall(sender:)), for: .touchUpInside)
                
                cell.clickDirection.addTarget(self, action: #selector(didtapDirection(sender:)), for: .touchUpInside)

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
           
            cell.emailIdFld.delegate = self
            cell.nameTextFld.delegate = self
            cell.mobileNoFld.delegate = self
            
            cell?.emailIdFld.tag = FieldIdentifier.email.rawValue
            cell?.nameTextFld.tag = FieldIdentifier.name.rawValue
            cell?.mobileNoFld.tag = FieldIdentifier.mobile.rawValue

            
          
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
                if self.eventData[0].covers.count > 0 {
                    let cellModal = self.eventData[0] as EventlistModel
                    return (CGFloat(cellModal.covers.count*45+40))
                }else{
                    return 0
                }
            }
            return 0
        }else if indexPath.section == 5{
                 
            
            if eventData.count > 0 {
               
                if self.eventData[0].packages.count > 0 {
                    
                               if self.eventData.count > 0 && self.heightOfCell>0 && self.heightindex == indexPath.row{
                                   print(self.heightOfCell)
                                   return CGFloat(self.heightOfCell)
                                   
                               }else if self.eventData.count > 0 && self.heightOfCell>0 && self.heightindex == 1{
                                   print(self.heightOfCell)
                                                  return CGFloat(self.heightOfCell)
                               }else{
                                   if self.eventData.count > 0{
                                   let cellModal = self.eventData[0].packages as [EventPackagesDetailModal]
                                   let height = Int(((cellModal.count)*(140))+40)
                                      
                                       return CGFloat(height)
                                   }
                               }
                }else{
                    return 0
                }
            }
            return 0
        }else if indexPath.section == 6{
            
            if self.eventData.count > 0 {
                if self.eventData[0].type == "restaurant"{
                    return 0
                }
            }
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
           self.heightOfCell = Int(((cellModal.count)*(140))+40)
           self.tblView.reloadData()
        }
        }
    }
    
    func validateEventPackages () {
        var counter = 0
        var mobile = mobileString
        mobile  = mobile?.replacingOccurrences(of:" ", with:"")
        mobile = mobile?.replacingOccurrences(of:"-", with:"")

        let eventModel = self.eventData
        print(eventModel)
        
        
        var params: [String: Any] =
            [
                "email" : emailString ?? "",
                "mobile" : mobile ?? "",
                "name" : nameString ?? "",
              
        ]
        if eventModel[0].covers.count > 0 {
                   params["men"] = "\(eventModel[0].covers[0].packageCount ?? 0)"
               }
        else{
            params["men"] = "0"
        }
        if eventModel[0].covers.count > 1 {
                   params["women"] = "\(eventModel[0].covers[1].packageCount ?? 0)"
               }
        else{
            params["women"] = "0"
        }
        if eventModel[0].covers.count > 2 {
            params["couple"] = "\(eventModel[0].covers[2].packageCount ?? 0)"
        }else{
            params["couple"] = "0"
        }
        
        if type != "" {
            params["type"] = "event"
        }
        
        for cover in eventModel[0].covers {
            if (cover.packageCount ?? 0 > 0) {
                params["itemid[\(counter)]"] = cover.id
                params["pass[\(counter)]"] = cover.packageCount
                counter = counter + 1
            }
        }
        
        for package in eventModel[0].packages {
            if (package.packageCount ?? 0 > 0) {
                params["itemid[\(counter)]"] = package.id
                params["pass[\(counter)]"] = package.packageCount
                counter = counter + 1
            }
        }
        
        print(params)
        self.bookOrder(json: params)
    }
    
    func bookOrder(json:[String:Any])  {
        Loader.showHud()
           Multipart().formDataAPICall(mainView: self.view, urlString: Server.shared.bookOrder, parameter: json, handler: { (response, isSuccess) in
               
             Loader.dismissHud()
               if isSuccess{
                   let result = response as! Dictionary<String,Any>
                print(result)
                if ((result["status_code"]as? Int ?? 0)==422){
                    self.showAlert(result["message"]as? String ?? "" )
                }else{
                  
                    let vc = EventCartViewController.instantiate(appStoryboard: .events) as EventCartViewController
                    vc.type = self.type
                    vc.dataDict = result as Dictionary<String, AnyObject>
                    self.navigationController?.pushViewController(vc, animated: true)
                                     
                }
               }
           })
       }
    
    
    
    @objc func didTapToOpenEventCart(sender:UIButton) -> Void {
        
        self.view.endEditing(true)
        
        if self.type == "party" {
            let vc = BookingViewController.instantiate(appStoryboard: .dinning) as BookingViewController
            vc.type = "party"
            vc.screen = "party"
            vc.partyModal = self.eventData
            

            let popupVC = PopupViewController(contentController: vc, popupWidth: (UIScreen.main.bounds.size.width - 20), popupHeight: (UIScreen.main.bounds.size.height - 20))
            
            popupVC.cornerRadius = 10
            present(popupVC, animated: true)
            //self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            
            
            let isValidPhone = Validation.validatePhone(phone: mobileString ?? "")
            let isValidEmail = Validation.isValidEmail(email: emailString ?? "")
            
            
            var count = 0
            
            
            if (nameString ?? "").count == 0 {
                count = count + 1
                showAlert("Please enter Name")
                return
            }
            if !isValidEmail {
                count = count + 1
                showAlert("Please enter Valid Email")
                return
            }
            if !isValidPhone {
                count = count + 1
                showAlert("Please enter Valid Phone Number")
                
                return
            }
            
            
            
            // All checked
            if count == 0 {
                // Event details API call
                self.validateEventPackages()
            }
            
        }
        
    }
    
    
    
}

