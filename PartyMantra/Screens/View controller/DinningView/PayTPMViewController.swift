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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSelected = ""
        self.tblView.rowHeight = 44
        self.tblView.estimatedRowHeight = UITableView.automaticDimension
        
        self.tblView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpTabBarAndNavigationTitle(tabBarHidden: true, navigationTitle: "Pay Bill")
    }
    
    
    @objc func didTapOnInstantDiscountRadioBtn (sender : UIButton) {
        
        sender.isSelected =  !sender.isSelected
        final_amount = amount

        
        let payAmount = Double(amount ?? "0") ?? 0.0
        if sender.isSelected {
            if payAmount > 0 {
                btnSelected = "instant"
                let amt = (10 * payAmount)/100
                cashbackamount = "\(amt)"
                discountedamount = "\(payAmount - amt)"
                
                final_amount = cashbackamount

            }
            

            
            self.tblView.reloadData()
        }
        
        
    }
    @objc func didTapOnDiscountRadioBtn (sender : UIButton) {
        sender.isSelected =  !sender.isSelected
        final_amount = amount

        let payAmount = Double(amount ?? "0") ?? 0.0
        if sender.isSelected {
            if payAmount > 0 {
                btnSelected = "cashback"
                let amt = (20 * payAmount)/100
                cashbackamount = "\(amt)"
                discountedamount = "\(payAmount - amt)"
                final_amount = cashbackamount

            }
            self.tblView.reloadData()
        }
        
        
    }
    @objc func didTapOnPayNowBtn (sender : UIButton) {
        
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
        final_amount = amount
    }
}
