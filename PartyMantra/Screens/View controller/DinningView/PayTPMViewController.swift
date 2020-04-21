//
//  PayTPMViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 16/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class PayTPMViewController: BaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var amount: String?
    var final_amount: String?
    var discountedamount: String?
    var cashbackamount: String?
    var btnSelected: String?
    var rest_title: String?
    var entityId: String?
    var pay = PaymentViewController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSelected = ""
        self.tblView.rowHeight = 44
        self.tblView.estimatedRowHeight = UITableView.automaticDimension
        
        self.tblView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationForPayTPM(notification:)), name: Notification.Name("PayTPMNotificationIdentifier"), object: nil)
    }
    
    
    @objc func methodOfReceivedNotificationForPayTPM(notification: Notification) {
        
        let vc = SuccessViewController.instantiate(appStoryboard: .miscellaneous) as SuccessViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpTabBarAndNavigationTitle(tabBarHidden: true, navigationTitle: "Pay Bill")
    }
    
    
    @objc func didTapOnInstantDiscountRadioBtn (sender : UIButton) {
        self.view.endEditing(true)
        
        sender.isSelected =  !sender.isSelected
        
        
        let payAmount = Double(amount ?? "0") ?? 0.0
        if sender.isSelected {
            if payAmount > 0 {
                btnSelected = "instant"
                let amt = (10 * payAmount)/100
                cashbackamount = "\(amt)"
                discountedamount = "\(payAmount - amt)"
            }
            
            
            
            self.tblView.reloadData()
        }
        
        
    }
    @objc func didTapOnDiscountRadioBtn (sender : UIButton) {
        self.view.endEditing(true)
        
        sender.isSelected =  !sender.isSelected
        
        let payAmount = Double(amount ?? "0") ?? 0.0
        if sender.isSelected {
            if payAmount > 0 {
                btnSelected = "cashback"
                let amt = (20 * payAmount)/100
                cashbackamount = "\(amt)"
                discountedamount = "\(payAmount - amt)"
            }
            self.tblView.reloadData()
        }
        
        
    }
    @objc func didTapOnPayNowBtn (sender : UIButton) {
        self.view.endEditing(true)
        let amt = Double(amount ?? "0.0")
        let final_amount = String(format: "%0.0f",amt ?? 0.0 )

        
        if btnSelected == "instant" {
            self.payTPMAPICall(amount: final_amount,buttonSelected: btnSelected ?? "")
        }
        else{
            self.payTPMAPICall(amount: final_amount,buttonSelected: btnSelected ?? "")
            
        }
        
        
    }
    
    
    
    func payTPMAPICall (amount : String, buttonSelected : String) {
        let param: [String: Any] = [
            "amount" : Int(amount) ?? 0,
            "entity_id": entityId ?? "",
            "discount_type": buttonSelected
        ]
        
        Loader.showHud()
        Multipart().formDataAPICall(mainView: self.view, urlString: Server.shared.paybillUrl, parameter:param, handler: { (response, isSuccess) in
            
            if isSuccess{
                Loader.dismissHud()
                let response = response as! Dictionary<String,Any>
                
                print(response)
                
                let responseDict = response["data"] as! Dictionary<String,Any>
                print(responseDict)
                
                let payStr = (responseDict["total"] ?? "0")
                let orderIDStr = (responseDict["orderid"] ?? "0")
                
                self.pay.addMoneyToPay(amount: "\(payStr)", payOrderid: "\(orderIDStr)", screen: "paytpm")
                
            }
        })
        
    }
    
    
    
    
    //MARK:- Tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
        cell?.selectionStyle = .none
        cell?.amountField.delegate = self
        cell?.radio1Btn.addTarget(self, action: #selector(didTapOnInstantDiscountRadioBtn(sender:)), for: .touchUpInside)
        cell?.radio2Btn.addTarget(self, action: #selector(didTapOnDiscountRadioBtn(sender:)), for: .touchUpInside)
        cell?.payNowBtn.addTarget(self, action: #selector(didTapOnPayNowBtn(sender:)), for: .touchUpInside)
        cell?.amountField.text = amount ?? ""
        cell?.amountField.placeholder = "Enter Amount"
        cell?.amountField.keyboardType = .numberPad
        
        
        
        cell?.titleLbl.text = rest_title ?? ""
        cell?.subtitleLbl.text = "Pay Bill Amount"
        cell?.discount1.text = "Instant Discount (10%)"
        cell?.discount2.text = "Cashback (20%)"
        
        cell?.totalAmount.text = "\u{20B9}\(discountedamount ?? "0")"
        
        
        if btnSelected == "instant" {
            cell?.discountAmount.isHidden = false
            cell?.totalAmount.isHidden = false
            
            cell?.radio1ImgView.image = UIImage(named: "radio_checked")
            cell?.radio2ImgView.image = UIImage(named: "radio_unchecked")
            
            cell?.discountAmount.text = "\u{20B9}\(cashbackamount ?? "0")"
            
        }
        else if btnSelected == "cashback" {
            cell?.discountAmount.isHidden = false
            cell?.totalAmount.isHidden = false
            
            cell?.radio1ImgView.image = UIImage(named: "radio_unchecked")
            cell?.radio2ImgView.image = UIImage(named: "radio_checked")
            cell?.discountAmount.text = "You will get \u{20B9}\(cashbackamount ?? "0")\ncashback in 24 Hrs"
            
        }
        else{
            cell?.radio1ImgView.image = UIImage(named: "radio_unchecked")
            cell?.radio2ImgView.image = UIImage(named: "radio_unchecked")
            
            cell?.discountAmount.isHidden = true
            cell?.totalAmount.isHidden = true
        }
        
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    //MARK:- Textfield delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        amount = textField.text ?? ""
    }
}
