//
//  BookingViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 08/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class BookingViewController: BaseViewController , UITextFieldDelegate{
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.estimatedRowHeight = 44.0
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    
    
    
    @objc func continueToCart() {
        
    }
    @objc func didTapCrossbtn() {
        
    }
    
    // slot
    @objc func didTapOnMenMinus() {
        
    }
    @objc func didTapOnMenPlus() {
        
    }
    
    @objc func didTapOnWomenMinus() {
        
    }
    @objc func didTapOnWomenPlus() {
        
    }
    
    @objc func didTapOnCoupleMinus() {
        
    }
    @objc func didTapOnCouplePlus() {
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 100 {
            
        }
        if textField.tag == 101 {
            
        }
        if textField.tag == 102 {
            
        }
        
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
            cell?.titleLb.text = "Testing"
            cell?.logoImgView.image = UIImage(named: "cross")
            
            return cell!
        }
        else if indexPath.row == 1 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "calendarCell") as? CalenderTableViewCell
            //            cell?.fscalender.delegate = self
            
            return cell!
        }
        else if indexPath.row == 2 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "timeslotCell") as? TimeCollectionCell
            
            return cell!
        }
        else if indexPath.row == 3 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "personCell") as? StackTableViewCell
            
            cell?.plusBtnMen.addTarget(self, action: #selector(didTapOnMenPlus), for: .touchUpInside)
            cell?.minusBtnMen.addTarget(self, action: #selector(didTapOnMenMinus), for: .touchUpInside)
            
            cell?.plusBtnWomen.addTarget(self, action: #selector(didTapOnWomenPlus), for: .touchUpInside)
            cell?.minusBtnWomen.addTarget(self, action: #selector(didTapOnWomenMinus), for: .touchUpInside)
            
            cell?.plusBtnCouple.addTarget(self, action: #selector(didTapOnCouplePlus), for: .touchUpInside)
            cell?.minusBtnCouple.addTarget(self, action: #selector(didTapOnCoupleMinus), for: .touchUpInside)
            
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


