//
//  MyProfileUpdateViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 27/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
enum FieldIdentifier: Int {
    case name = 0
    case gender = 1
    case dob = 2
    case phone = 3
    case email = 4
    case image=5
}


class MyProfileUpdateViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var profile: ProfileModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.tableFooterView = UIView()
        
      
        // Do any additional setup after loading the view.
    }
}

extension MyProfileUpdateViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if FieldIdentifier.name.rawValue == textField.tag {
            self.profile?.name = textField.text
        }
        else if FieldIdentifier.dob.rawValue == textField.tag {
            self.profile?.dob = textField.text
            
        }
        else if FieldIdentifier.email.rawValue == textField.tag {
            self.profile?.email = textField.text
            
        }
        else if FieldIdentifier.phone.rawValue == textField.tag {
            self.profile?.mobile = textField.text
            
        }
        
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//   logic for mobile email
//    }
}
extension MyProfileUpdateViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ImgCell") as? MyProfileUpdateTableViewCell
        
        if indexPath.section  == 0 && indexPath.row == 0{
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ImgCell") as? MyProfileUpdateTableViewCell
            
            let url = URL(string: profile?.image ?? "")
            cell?.logoImageView.contentMode = .scaleAspectFill
            cell?.logoImageView.kf.setImage(with: url, placeholder: nil)
            
            cell?.logoEditImageView.layer.masksToBounds = true
            cell?.logoEditImageView.layer.cornerRadius = 5
            cell?.logoEditImageView.layer.borderWidth = 1
            cell?.logoEditImageView.layer.borderColor = UIColor.yellow.cgColor
            
            return cell!
        }
        else if indexPath.section  == 1{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
            
            if indexPath.row == 0 {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                
                cell?.nameLabel.text = "Name"
                cell?.nameTextField.text = self.profile?.name ?? ""
                cell?.nameTextField.tag = FieldIdentifier.name.rawValue
                cell?.dropdownButton.isHidden = true
                cell?.imgDropdown.isHidden = true
                
                cell?.nameView.layer.cornerRadius = 10
                cell?.nameView.layer.masksToBounds = true
                
                return cell!
            }
            else if indexPath.row  == 1{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                cell?.nameLabel.text = "Gender"
                cell?.nameTextField.text = self.profile?.gender ?? ""
                cell?.nameTextField.tag = FieldIdentifier.gender.rawValue

                cell?.dropdownButton.isHidden = false
                cell?.imgDropdown.isHidden = false
                
                // cell?.dropdownButton.image = UIImage(named: "dropdown")
                cell?.nameView.layer.cornerRadius = 10
                cell?.nameView.layer.masksToBounds = true
                return cell!
                
            }
            else if indexPath.row  == 2{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                cell?.nameLabel.text = "DOB"
                cell?.nameTextField.text = self.profile?.dob ?? ""
                cell?.nameTextField.tag = FieldIdentifier.dob.rawValue

                cell?.dropdownButton.isHidden = false
                cell?.imgDropdown.isHidden = false
                
                //cell?.disclosureImgView.image = UIImage(named: "starnew")
                cell?.nameView.layer.cornerRadius = 10
                cell?.nameView.layer.masksToBounds = true
                return cell!
                
            }
            else if indexPath.row  == 3{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                cell?.nameLabel.text = "Phone"
                cell?.nameTextField.text = self.profile?.mobile ?? ""
                cell?.nameTextField.tag = FieldIdentifier.phone.rawValue

                cell?.dropdownButton.isHidden = true
                cell?.imgDropdown.isHidden = true
                
                cell?.nameView.layer.cornerRadius = 10
                cell?.nameView.layer.masksToBounds = true
                
                return cell!
                
            }
            else if indexPath.row  == 4{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                cell?.nameLabel.text = "Email"
                cell?.nameTextField.text = self.profile?.email ?? ""
                cell?.nameTextField.tag = FieldIdentifier.email.rawValue

                cell?.dropdownButton.isHidden = true
                cell?.imgDropdown.isHidden = true
                
                cell?.nameView.layer.cornerRadius = 10
                cell?.nameView.layer.masksToBounds = true
                
                return cell!
                
            }
            else if indexPath.row  == 5{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddessTableViewCell") as? MyProfileUpdateTableViewCell
                
                cell?.addressLabel.text = "Address"
                cell?.fulladressLabel.text = self.profile?.address ?? ""
                
                
                cell?.adressView.layer.cornerRadius = 10
                cell?.adressView.layer.masksToBounds = true
                
                cell?.fulladressLabel.layer.masksToBounds = true
                cell?.fulladressLabel.layer.cornerRadius = 5
                cell?.fulladressLabel.layer.borderWidth = 1
                cell?.fulladressLabel.layer.borderColor = UIColor.lightGray.cgColor
                
                
                return cell!
            }
            
            return cell!
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        return UITableView.automaticDimension
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 2
        }
        
        return 0
    }
    
    
    
}
