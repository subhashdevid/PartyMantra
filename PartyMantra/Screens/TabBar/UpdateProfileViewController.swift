//
//  UpdateProfileViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 26/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var profile : ProfileModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.estimatedRowHeight = 44.0
        self.tblView.tableFooterView = UIView()
    }
}


extension UpdateProfileViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //default
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ImgCell") as? ProfileTableViewCell
        
        if indexPath.section  == 0{
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "ImgCell") as? ProfileTableViewCell
            return cell!
            
        }
        else if indexPath.section  == 1{
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblFieldCell") as? ProfileTableViewCell
            
            cell?.titleLbl.text = "Name"
            cell?.titleField.text = "Shikha Ranni"
            cell?.disclosureImgView.isHidden = true

            
            return cell!
            
        }
        else if indexPath.section  == 2{
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblFieldCell") as? ProfileTableViewCell
            cell?.titleLbl.text = "Gender"
            cell?.titleField.text = "Female"
            cell?.disclosureImgView.isHidden = false
            cell?.disclosureImgView.image = UIImage(named: "starnew")
            
            return cell!
            
        }
        else if indexPath.section  == 3{
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblFieldCell") as? ProfileTableViewCell
            cell?.titleLbl.text = "DOB"
            cell?.titleField.text = "25/apr/1989"
            cell?.disclosureImgView.isHidden = false
            cell?.disclosureImgView.image = UIImage(named: "starnew")

            return cell!
            
        }
        else if indexPath.section  == 4{
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblFieldCell") as? ProfileTableViewCell
            cell?.titleLbl.text = "Phone"
            cell?.titleField.text = "Shikha Ranni"
            cell?.disclosureImgView.isHidden = true

            
            return cell!
            
        }
        else if indexPath.section  == 5{
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "lblFieldCell") as? ProfileTableViewCell
            cell?.titleLbl.text = "Email"
            cell?.titleField.text = "Shikha Ranni"
            cell?.disclosureImgView.isHidden = true

            
            return cell!
            
        }
        else if indexPath.section  == 6{
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "twoLblCell") as? ProfileTableViewCell
            
            cell?.titleLbl.text = "Address"
            cell?.suiTtleLbl.text = " Shikha RanniShikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni"
            
            
            return cell!
        }
        return cell!
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }
        return UITableView.automaticDimension
    }



}



extension UpdateProfileViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
    
}
