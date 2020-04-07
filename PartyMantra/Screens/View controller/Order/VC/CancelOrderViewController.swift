//
//  CancelOrderViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 01/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class CancelOrderViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var topBreadcrum: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var crossbtn: UIButton!
    @IBOutlet weak var submitbtn: UIButton!
    
    var selectedIndex : IndexPath?
    var cancel_dict : [String : Any]?
    var refid : String?
    var orderString : String?
    var reasonId : String?
    
    var reasonString : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.crossbtn.addTarget(self, action: #selector(didTapCrossBtn), for: .touchUpInside)
        submitbtn.addTarget(self, action: #selector(didTapOKBtn), for: .touchUpInside)
    }
    
    @objc func didTapCrossBtn() {
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapOKBtn() {
        submit()
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        reasonString = textView.text
    }
}


extension CancelOrderViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 100
        }
        return 40
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblImg") as? CancelOrderTableViewCell
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblImg") as? CancelOrderTableViewCell
                let dic = self.cancel_dict as? [String: String]
                let str = dic?["1"] ?? ""
                cell?.titlelLbl?.text = str
                if indexPath.row == selectedIndex?.row {
                    cell?.logoImageView.image = UIImage(named: "radio_checked")
                }else{
                    cell?.logoImageView.image = UIImage(named: "radio_unchecked")
                }
                
                return cell!
                
            }
            if indexPath.row == 1 {
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblImg") as? CancelOrderTableViewCell
                let dic = self.cancel_dict as? [String: String]
                let str = dic?["2"] ?? ""
                cell?.titlelLbl?.text = str
                if indexPath.row == selectedIndex?.row {
                    cell?.logoImageView.image = UIImage(named: "radio_checked")
                }else{
                    cell?.logoImageView.image = UIImage(named: "radio_unchecked")
                }
                return cell!
                
            }
            if indexPath.row == 2 {
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblImg") as? CancelOrderTableViewCell
                let dic = self.cancel_dict as? [String: String]
                let str = dic?["3"] ?? ""
                cell?.titlelLbl?.text = str
                if indexPath.row == selectedIndex?.row {
                    cell?.logoImageView.image = UIImage(named: "radio_checked")
                }else{
                    cell?.logoImageView.image = UIImage(named: "radio_unchecked")
                }
                return cell!
                
            }
            if indexPath.row == 3 {
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblImg") as? CancelOrderTableViewCell
                let dic = self.cancel_dict as? [String: String]
                let str = dic?["4"] ?? ""
                
                cell?.titlelLbl.text = str
                if indexPath.row == selectedIndex?.row {
                    cell?.logoImageView.image = UIImage(named: "radio_checked")
                }else{
                    cell?.logoImageView.image = UIImage(named: "radio_unchecked")
                }
                return cell!
                
            }
            return cell!
        }
        else {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "txtviewCell") as? CancelOrderTableViewCell
            cell?.reasonTextview.placeholder = "Write you comment"
            cell?.reasonTextview.layer.borderWidth = 1
            cell?.reasonTextview.layer.borderColor = UIColor.gray.cgColor
            cell?.reasonTextview.text = reasonString ?? ""
            cell?.reasonTextview.delegate = self
            
            return cell!
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath
        let cell = self.tblView.cellForRow(at: indexPath) as? CancelOrderTableViewCell
        cell?.logoImageView.image = UIImage(named: "radio_checked")
        orderString = cell?.titlelLbl.text ?? ""
        reasonId = "\(indexPath.row + 1)"
        self.tblView.reloadData()
    }
    
    func createUrl() -> String {
        var url = ""
        url = Server.shared.cancelOrderUrl + "/\(refid ?? "")"
        return url
    }
    
    func submit()  {
        if reasonId == "" {
            showAlert("Please select a reason ")
        }else{
            let param: [String: String] = [
                "reason_id" : reasonId ?? "",
                "reason_text" : reasonString ?? "t"
            ]
            Loader.showHud()
            Multipart().saveDataUsingMultipart(mainView: self.view, urlString: createUrl(), parameter: param as? [String : String], handler: { (response, isSuccess) in
                
                Loader.dismissHud()
                
                if isSuccess{
                    let res = response as! Dictionary<String,Any>
                    print(res)
                    let status = res["status"] ?? "" as? String
                    let message = res["message"] ?? ""
                    
                    if status as? String == "success" {
                        self.showPopUpMessage(message as! String)
                        
                    }
                    else{
                        self.showPopUpMessage(message as! String)
                    }
                }
            })
        }
    }
    
    
    func showPopUpMessage(title: String = "" ,_ message:String, dismissPopup: Bool = true){
        let alert = UIAlertController(title: title, message:message
            , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            if dismissPopup {
                self.didTapCrossBtn()
                self.dismiss(animated: true, completion: nil)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
