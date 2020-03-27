//
//  MyProfileUpdateViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 27/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class MyProfileUpdateViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MyProfileUpdateViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ImgCell") as? MyProfileUpdateTableViewCell
        
        if indexPath.section  == 0{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ImgCell") as? MyProfileUpdateTableViewCell
            return cell!
            
        }
            
        else if indexPath.section  == 1{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                
                cell?.nameLabel.text = "Name"
                cell?.nameTextField.text = "Shikha Ranni"
                cell?.dropdownButton.isHidden = true
            cell?.imgDropdown.isHidden = true

            cell?.nameView.layer.cornerRadius = 10
            cell?.nameView.layer.masksToBounds = true

                return cell!
                
            }
            else if indexPath.section  == 2{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                cell?.nameLabel.text = "Gender"
                cell?.nameTextField.text = "Female"
                cell?.dropdownButton.isHidden = false
            cell?.imgDropdown.isHidden = false

               // cell?.dropdownButton.image = UIImage(named: "dropdown")
                cell?.nameView.layer.cornerRadius = 10
                cell?.nameView.layer.masksToBounds = true
                return cell!
                
            }
            else if indexPath.section  == 3{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                cell?.nameLabel.text = "DOB"
                cell?.nameTextField.text = "25/apr/1989"
                cell?.dropdownButton.isHidden = false
            cell?.imgDropdown.isHidden = false

                //cell?.disclosureImgView.image = UIImage(named: "starnew")
                cell?.nameView.layer.cornerRadius = 10
                cell?.nameView.layer.masksToBounds = true
                return cell!
                
            }
            else if indexPath.section  == 4{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                cell?.nameLabel.text = "Phone"
                cell?.nameTextField.text = "Shikha Ranni"
                cell?.dropdownButton.isHidden = true
            cell?.imgDropdown.isHidden = true

            cell?.nameView.layer.cornerRadius = 10
           cell?.nameView.layer.masksToBounds = true
                
                return cell!
                
            }
            else if indexPath.section  == 5{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? MyProfileUpdateTableViewCell
                cell?.nameLabel.text = "Email"
                cell?.nameTextField.text = "Shikha Ranni"
                cell?.dropdownButton.isHidden = true
            cell?.imgDropdown.isHidden = true

            cell?.nameView.layer.cornerRadius = 10
                       cell?.nameView.layer.masksToBounds = true
                
                return cell!
                
            }
            else if indexPath.section  == 6{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddessTableViewCell") as? MyProfileUpdateTableViewCell
                
                cell?.addressLabel.text = "Address"
                cell?.fulladressLabel.text = " Shikha RanniShikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni Shikha Ranni"

                           cell?.adressView.layer.cornerRadius = 10
                                cell?.adressView.layer.masksToBounds = true
                
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
