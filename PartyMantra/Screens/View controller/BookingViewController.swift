//
//  BookingViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 08/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import FSCalendar

protocol BookingDetailProtocol {
    func getbookingDetail(screentype:String, dict: Dictionary<String, AnyObject>) -> Void
}


class BookingViewController: BaseViewController , UITextFieldDelegate, FSCalendarDataSource, FSCalendarDelegate, TimeCollectionCellDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    var restModal : RestaurantInfoModel?
    var partyModal : [EventlistModel] = []
    
    var bookingDelegate: BookingDetailProtocol?
    
    var type: String?
    var screen: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.estimatedRowHeight = 44.0
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
        self.tblView.layer.cornerRadius = 10
        
    }
    
    
    func didTimeSlotCellPressed(timeStr: String) {
        
        
        if screen == "party" {
            self.partyModal[0].time_selected = timeStr

        }
        else{
            self.restModal?.time_selected = timeStr

        }
            
            
            
    }
    @objc func continueToCart() {
        
        self.view.endEditing(true)
        
        
        let restaurant = self.restModal
        let party = self.partyModal
        
        
        
        
        if screen == "party" {
            let isValidPhone = Validation.validatePhone(phone:  party[0].field_number ?? "")
            let isValidEmail = Validation.isValidEmail(email: party[0].field_email ?? "")
            
            var count = 0
            
            if (party[0].field_name ?? "").count == 0 {
                count = count + 1
                showAlert("Please enter Name")
                return
                
            }
            if !isValidPhone{
                count = count + 1
                showAlert("Please enter valid Phone Number")
                
                return
                
            }
            if !isValidEmail {
                count = count + 1
                showAlert("Please enter valid Email")
                return
                
            }
            if (party[0].cal_date ?? "").count == 0 {
                count = count + 1
                showAlert("Please select booking date")
                return
            }
            if (party[0].time_selected ?? "").count == 0 {
                count = count + 1
                showAlert("Please select time of Booking")
                return
            }
            
            
            
            if count == 0 {
                validateEventPackages()
            }
            
        }
        else{
            let isValidPhone = Validation.validatePhone(phone:  restaurant?.field_number ?? "")
            let isValidEmail = Validation.isValidEmail(email: restaurant?.field_email ?? "")
            
            var count = 0
            
            if (restaurant?.field_name ?? "").count == 0 {
                count = count + 1
                showAlert("Please enter Name")
                return
                
            }
            if !isValidPhone{
                count = count + 1
                showAlert("Please enter valid Phone Number")
                
                return
                
            }
            if !isValidEmail {
                count = count + 1
                showAlert("Please enter valid Email")
                return
                
            }
            if (restaurant?.cal_date ?? "").count == 0 {
                count = count + 1
                showAlert("Please select booking date")
                return
            }
            if (restaurant?.time_selected ?? "").count == 0 {
                count = count + 1
                showAlert("Please select time of Booking")
                return
            }
            
            
            if count == 0 {
                validateEventPackages()
            }
            
        }
        
        
    }
    @objc func didTapCrossbtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // slot
    @objc func didTapOnMenMinus( sender : UIButton) {
        guard let cell = sender.superview?.superview?.superview?.superview as? StackTableViewCell else {
            return
        }
        
        if screen == "party" {
            if ((self.partyModal[0].menCounter ?? 0) <= 0) {
                self.partyModal[0].menCounter = (self.partyModal[0].menCounter ?? 0) - 0
            }
            else{
                self.partyModal[0].menCounter = (self.partyModal[0].menCounter ?? 0) - 1
            }
            
            cell.menCount.text = "\(self.partyModal[0].menCounter ?? 0)"
        }
        else{
            if ((self.restModal?.menCounter ?? 0) <= 0) {
                self.restModal?.menCounter = (self.restModal?.menCounter ?? 0) - 0
            }
            else{
                self.restModal?.menCounter = (self.restModal?.menCounter ?? 0) - 1
            }
            
            cell.menCount.text = "\(self.restModal?.menCounter ?? 0)"
        }
        
        
        
    }
    @objc func didTapOnMenPlus(sender : UIButton ) {
        
        guard let cell = sender.superview?.superview?.superview?.superview as? StackTableViewCell else {
            return
        }
        
        if screen == "party" {
            if (self.partyModal[0].menCounter ?? 0 <= 10) {
                self.partyModal[0].menCounter = (self.partyModal[0].menCounter ?? 0) + 1
            }
            else{
                self.self.partyModal[0].menCounter = (self.partyModal[0].menCounter ?? 0) + 0
            }
            cell.menCount.text = "\(self.partyModal[0].menCounter ?? 0)"
            
        }
        else{
            if (self.restModal?.menCounter ?? 0 <= 10) {
                self.restModal?.menCounter = (self.restModal?.menCounter ?? 0) + 1
            }
            else{
                self.restModal?.menCounter = (self.restModal?.menCounter ?? 0) + 0
            }
            cell.menCount.text = "\(self.restModal?.menCounter ?? 0)"
        }
        
        
        
    }
    
    @objc func didTapOnWomenMinus(sender : UIButton) {
        guard let cell = sender.superview?.superview?.superview?.superview as? StackTableViewCell else {
            return
        }
        
        
        if screen == "party" {
            if (self.partyModal[0].womenCounter ?? 0 <= 0) {
                self.partyModal[0].womenCounter = (self.partyModal[0].womenCounter ?? 0) - 0
            }
            else{
                self.partyModal[0].womenCounter = (self.partyModal[0].womenCounter ?? 0) - 1
            }
            
            cell.womenCount.text = "\(self.partyModal[0].womenCounter ?? 0)"
        }
        else{
            if (self.restModal?.womenCounter ?? 0 <= 0) {
                self.restModal?.womenCounter = (self.restModal?.womenCounter ?? 0) - 0
            }
            else{
                self.restModal?.womenCounter = (self.restModal?.womenCounter ?? 0) - 1
            }
            
            cell.womenCount.text = "\(self.restModal?.womenCounter ?? 0)"
        }
        
        
    }
    @objc func didTapOnWomenPlus(sender : UIButton) {
        
        guard let cell = sender.superview?.superview?.superview?.superview as? StackTableViewCell else {
            return
        }
        if screen == "party" {
            if (self.partyModal[0].womenCounter ?? 0 <= 10) {
                self.partyModal[0].womenCounter = (self.partyModal[0].womenCounter ?? 0) + 1
            }
            else{
                self.partyModal[0].womenCounter = (self.partyModal[0].womenCounter ?? 0) + 0
            }
            cell.womenCount.text = "\(self.partyModal[0].womenCounter ?? 0)"
        }
        else{
            if (self.restModal?.womenCounter ?? 0 <= 10) {
                self.restModal?.womenCounter = (self.restModal?.womenCounter ?? 0) + 1
            }
            else{
                self.restModal?.womenCounter = (self.restModal?.womenCounter ?? 0) + 0
            }
            cell.womenCount.text = "\(self.restModal?.womenCounter ?? 0)"
        }
        
    }
    
    @objc func didTapOnCoupleMinus(sender : UIButton) {
        guard let cell = sender.superview?.superview?.superview?.superview as? StackTableViewCell else {
            return
        }
        
        if screen == "party" {
            if (self.partyModal[0].coupleCounter ?? 0 <= 0) {
                self.partyModal[0].coupleCounter = (self.partyModal[0].coupleCounter ?? 0) - 0
            }
            else{
                self.partyModal[0].coupleCounter = (self.partyModal[0].coupleCounter ?? 0) - 1
            }
            cell.coupleCount.text = "\(self.partyModal[0].coupleCounter ?? 0)"
        }
        else{
            if (self.restModal?.coupleCounter ?? 0 <= 0) {
                self.restModal?.coupleCounter = (self.restModal?.coupleCounter ?? 0) - 0
            }
            else{
                self.restModal?.coupleCounter = (self.restModal?.coupleCounter ?? 0) - 1
            }
            cell.coupleCount.text = "\(self.restModal?.coupleCounter ?? 0)"
        }
        
        
    }
    @objc func didTapOnCouplePlus(sender : UIButton) {
        
        guard let cell = sender.superview?.superview?.superview?.superview as? StackTableViewCell else {
            return
        }
        
        if screen == "party" {
            if (self.partyModal[0].coupleCounter ?? 0 < 10) {
                self.partyModal[0].coupleCounter = (self.partyModal[0].coupleCounter ?? 0) + 1
            }
            else{
                self.partyModal[0].coupleCounter = (self.partyModal[0].coupleCounter ?? 0) + 0
            }
            cell.coupleCount.text = "\(self.partyModal[0].coupleCounter ?? 0)"
        }
        else{
            if (self.restModal?.coupleCounter ?? 0 < 10) {
                self.restModal?.coupleCounter = (self.restModal?.coupleCounter ?? 0) + 1
            }
            else{
                self.restModal?.coupleCounter = (self.restModal?.coupleCounter ?? 0) + 0
            }
            cell.coupleCount.text = "\(self.restModal?.coupleCounter ?? 0)"
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      if textField.tag == 102 {

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
        if screen == "party" {
            if textField.tag == 100 {
                self.partyModal[0].field_name = textField.text
            }
            if textField.tag == 101 {
                self.partyModal[0].field_email = textField.text
                
            }
            if textField.tag == 102 {
                self.partyModal[0].field_number = textField.text
            }
        }
        else{
            if textField.tag == 100 {
                self.restModal?.field_name = textField.text
            }
            if textField.tag == 101 {
                self.restModal?.field_email = textField.text
                
            }
            if textField.tag == 102 {
                self.restModal?.field_number = textField.text
            }
        }
        
        
        
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
            print(date)
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatterPrint.string(from: date)
        
        //        if self.screen == "restaurant" {
        
        if screen == "party" {
            self.partyModal[0].cal_date = dateStr
            
        }
        else{
            self.restModal?.cal_date = dateStr
            
        }
        //        }
        
    }
    
    
    
    //MARK API CALL
    
    func validateEventPackages () {
        self.view.endEditing(true)
        let restaurant = self.restModal
        let party = self.partyModal
        
        
        
        var params: [String: Any] = [:]
        
        if screen == "party" {
            var number = party[0].field_number
            number  = number?.replacingOccurrences(of: " ", with: "")
            number  = number?.replacingOccurrences(of: "-", with: "")
            
            params["name"] = party[0].field_name ?? ""
            params["email"] = party[0].field_email ?? ""
            params["mobile"] = number
            params["date"] = party[0].cal_date ?? ""
            params["time"] = party[0].time_selected ?? ""
            params["men"] = "\(party[0].menCounter ?? 0)"
            params["women"] = "\(party[0].womenCounter ?? 0)"
            params["couple"] = "\(party[0].coupleCounter ?? 0)"
        }
        else{
            var number = restaurant?.field_number
                      number  = number?.replacingOccurrences(of: " ", with: "")
                      number  = number?.replacingOccurrences(of: "-", with: "")
            params["name"] = restaurant?.field_name ?? ""
            params["email"] = restaurant?.field_email ?? ""
            params["mobile"] = number
            params["date"] = restaurant?.cal_date ?? ""
            params["time"] = restaurant?.time_selected ?? ""
            params["men"] = "\(restaurant?.menCounter ?? 0)"
            params["women"] = "\(restaurant?.womenCounter ?? 0)"
            params["couple"] = "\(restaurant?.coupleCounter ?? 0)"
        }
        
        if type != "" {
            if screen == "party" {
                params["type"] = "party"
            }else{
                params["type"] = "restaurant"
            }
        }
        
        if screen == "party" {
            if party.count > 0 {
                params["entity_id"] = "\(party[0].id ?? 0)"
            }
        }else{
            params["entity_id"] = "\(restaurant?.id ?? 0)"
            
        }
        
        
        if screen != "party" {
            var counterMenu = 0
            for menu in restaurant?.menus  ?? []{
                if (menu.itemCount ?? 0 > 0) {
                    params["menuid[\(counterMenu)]"] = menu.id
                    params["quantity[\(counterMenu)]"] = menu.itemCount
                    counterMenu = counterMenu + 1
                }
            }
        }
        
        if screen == "party" {
            var counter = 0
            if (party.count > 0) {
                for package in party[0].packages {
                    if (package.packageCount ?? 0 > 0) {
                        params["itemid[\(counter)]"] = package.id
                        params["pass[\(counter)]"] = package.packageCount
                        counter = counter + 1
                    }
                }
            }
        }
        else{
            var counter = 0
            for package in restaurant?.packages ?? [] {
                if (package.packageCount ?? 0 > 0) {
                    params["itemid[\(counter)]"] = package.id
                    params["pass[\(counter)]"] = package.packageCount
                    counter = counter + 1
                }
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
                    
//                    let vc = EventCartViewController.instantiate(appStoryboard: .events) as EventCartViewController
//                    vc.type = self.type
//                    vc.dataDict = result as Dictionary<String, AnyObject>
//                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    let result = result as Dictionary<String, AnyObject>
                    self.bookingDelegate?.getbookingDetail(screentype: self.type ?? "", dict: result)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
}



//MARK:- table view delegate
extension BookingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "topViewCell") as? BookingTableViewCell
        
        if indexPath.row == 0 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "topViewCell") as? BookingTableViewCell
            
            cell?.crossBtn.addTarget(self, action: #selector(didTapCrossbtn), for: .touchUpInside)
            cell?.crossBtn.isHidden = false
            if screen == "party" {
                cell?.titleLb.text = self.partyModal[0].name
                let url = URL(string: self.partyModal[0].header_image ?? "")
                cell?.logoImgView.kf.setImage(with: url, placeholder: UIImage(named: "applogo_1024"))
            }else {
                cell?.titleLb.text = self.restModal?.name
                let url = URL(string: self.restModal?.header_image ?? "")
                cell?.logoImgView.kf.setImage(with: url, placeholder: UIImage(named: "applogo_1024"))
            }
            
            return cell!
        }
        else if indexPath.row == 1 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "calendarCell") as? CalenderTableViewCell
            cell?.fscalender.delegate = self
            cell?.fscalender.dataSource = self
            return cell!
        }
        else if indexPath.row == 2 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "timeslotCell") as? TimeCollectionCell
            
            if screen == "party" {
                cell?.timeArray = self.partyModal[0].party_timings?.components(separatedBy: ",") ?? [""]
            }
            else{
                cell?.timeArray = self.restModal?.timings?.components(separatedBy: ",") ?? [""]
                
            }
            
            cell?.timeCell_delegate = self
            return cell!
        }
        else if indexPath.row == 3 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "personCell") as? StackTableViewCell
            
            cell?.plusBtnMen.addTarget(self, action: #selector(didTapOnMenPlus(sender:)), for: .touchUpInside)
            cell?.minusBtnMen.addTarget(self, action: #selector(didTapOnMenMinus(sender:)), for: .touchUpInside)
            cell?.minusBtnMen.layer.cornerRadius = 12
            cell?.minusBtnMen.layer.masksToBounds = true
            cell?.minusBtnMen.layer.borderColor = UIColor.gray.cgColor
            cell?.minusBtnMen.layer.borderWidth = 1
            
            cell?.plusBtnMen.layer.cornerRadius = 12
                       cell?.plusBtnMen.layer.masksToBounds = true
                       cell?.plusBtnMen.layer.borderColor = UIColor.gray.cgColor
                       cell?.plusBtnMen.layer.borderWidth = 1
            

            
            cell?.plusBtnWomen.addTarget(self, action: #selector(didTapOnWomenPlus(sender:)), for: .touchUpInside)
            cell?.minusBtnWomen.addTarget(self, action: #selector(didTapOnWomenMinus(sender:)), for: .touchUpInside)
            
            cell?.minusBtnWomen.layer.cornerRadius = 12
            cell?.minusBtnWomen.layer.masksToBounds = true
            cell?.minusBtnWomen.layer.borderColor = UIColor.gray.cgColor
            cell?.minusBtnWomen.layer.borderWidth = 1
            
            cell?.plusBtnWomen.layer.cornerRadius = 12
                       cell?.plusBtnWomen.layer.masksToBounds = true
                       cell?.plusBtnWomen.layer.borderColor = UIColor.gray.cgColor
                       cell?.plusBtnWomen.layer.borderWidth = 1
            
            
            
            cell?.plusBtnCouple.addTarget(self, action: #selector(didTapOnCouplePlus(sender:)), for: .touchUpInside)
            cell?.minusBtnCouple.addTarget(self, action: #selector(didTapOnCoupleMinus(sender:)), for: .touchUpInside)
            
            
            cell?.plusBtnCouple.layer.cornerRadius = 12
                      cell?.plusBtnCouple.layer.masksToBounds = true
                      cell?.plusBtnCouple.layer.borderColor = UIColor.gray.cgColor
                      cell?.plusBtnCouple.layer.borderWidth = 1
                      
                      cell?.minusBtnCouple.layer.cornerRadius = 12
                                 cell?.minusBtnCouple.layer.masksToBounds = true
                                 cell?.minusBtnCouple.layer.borderColor = UIColor.gray.cgColor
                                 cell?.minusBtnCouple.layer.borderWidth = 1
            
            
            cell?.menCount.text = "0"
            cell?.womenCount.text = "0"
            cell?.coupleCount.text = "0"
            
            
            
            return cell!
        }
        else if indexPath.row == 4 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "threeFieldCell") as? BookingTableViewCell
            
            cell?.nameField.placeholder = "Enter Name"
            cell?.nameField.delegate = self
            cell?.nameField.tag = 100
            
            cell?.emailField.placeholder = "Enter Email"
            cell?.emailField.delegate = self
            cell?.emailField.tag = 101
            
            cell?.phoneField.placeholder = "Enter Phone Number"
            cell?.phoneField.delegate = self
            cell?.phoneField.tag = 102
            
            
            
            return cell!
            
        }
        else if indexPath.row == 5 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "btnCell") as? BookingTableViewCell
            cell?.continueBtn.addTarget(self, action: #selector(continueToCart), for: .touchUpInside)
            
            return cell!
            
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 120
            
        }
        else if indexPath.row == 1 {
            return 240
            
        }
        else if indexPath.row == 2 {
            return 120
            
        }
        else if indexPath.row == 3 {
            return 120
        }
        else if indexPath.row == 4 {
            return 180
            
        }
        else if indexPath.row == 5 {
            return 70
            
        }
        return UITableView.automaticDimension
    }
    
    
}


