//
//  MyProfileUpdateViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 27/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import DropDown


enum FieldIdentifier: Int {
    case name = 0
    case gender = 1
    case dob = 2
    case phone = 3
    case email = 4
    case image=5
}


class MyProfileUpdateViewController: UIViewController,ImagePickerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    
    var profile: ProfileModel?
    
    var validation = Validation()
    var imagePicker: ImagePicker!
    
    let dropDown = DropDown();
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.tableFooterView = UIView()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        
        // Do any additional setup after loading the view.
    }
    
    func showAlert(alertTitle:String, messageBody: String){
        
        let alert = UIAlertController(title: alertTitle, message: messageBody,preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func addProfileImage(sender:UIButton) -> Void {
        self.imagePicker.present(from: sender)
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        
        self.view.endEditing(true)
        
        guard let email = self.profile?.email,let phone = self.profile?.mobile,
            let name = self.profile?.name else {
                return
        }
        
        if name.isEmpty {
            showAlert(alertTitle: "Alert", messageBody: "Fields cannot be empty")
            return
        }
        
        let isValidatePhone = self.validation.validaPhoneNumber(phoneNumber: phone)
        if (isValidatePhone == false) {
            //print("Incorrect Phone")
            
            showAlert(alertTitle: "Alert", messageBody: "Please enter 10 digits phone number ")
            return
        }
        
        let isValidateEmail = self.validation.isValidEmail(email)
        if (isValidateEmail == false) {
            
            showAlert(alertTitle: "Alert", messageBody: "Please enter valid email id ")
            
            return
        }
        
        
        
        
        
    }
    
    func didSelect(image: UIImage?, tag: Int) {
    
    }
    
    
    @objc func dropdownAction (sender : UIButton) {
        
        guard let cell = sender.superview?.superview?.superview as? MyProfileUpdateTableViewCell else {
            return
        }
        
        let indexPath = self.tableView.indexPath(for: cell)
        
        //print(indexPath?.row ?? <#default value#>)
        
        
        
        
        
        let array = ["Male","Female","Other"]
        self.dropDown.anchorView = cell.nameTextField.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        self.dropDown.dataSource = array
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            self.profile?.gender = item
            cell.nameTextField.text =  self.profile?.gender
        }
        self.dropDown.show()
        
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
            
            cell?.logoImageButton.addTarget(self, action: #selector(addProfileImage(sender:)), for: .touchUpInside)
            
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
                cell?.dropdownButton.backgroundColor = .clear
                cell?.imgDropdown.isHidden = false
                
                cell?.dropdownButton?.addTarget(self, action: #selector(dropdownAction(sender:)), for: .touchUpInside)
                cell?.nameTextField.isUserInteractionEnabled = false
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
                cell?.nameTextField.isUserInteractionEnabled = false
                
                cell?.dropdownButton.isHidden = false
                cell?.dropdownButton.backgroundColor = .clear
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
                cell?.nameTextField.isUserInteractionEnabled = true
                
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
                cell?.nameTextField.isUserInteractionEnabled = true
                
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
