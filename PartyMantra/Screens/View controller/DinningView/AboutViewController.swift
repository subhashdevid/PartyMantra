//
//  AboutViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 06/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var topBreadcrum: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var crossbtn: UIButton!
    @IBOutlet weak var submitbtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
extension AboutViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
        
        if(indexPath.row == 0){
             let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
            
            cell?.cellImageView.image = UIImage(named: "home")
            cell?.titlelLbl.text = "Address"
            cell?.subtitleLbl.text = "Sector 3"
            return cell!

        }
        else if(indexPath.row == 1){
             let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
                       
                       cell?.cellImageView.image = UIImage(named: "home")
                       cell?.titlelLbl.text = "Address"
                       cell?.subtitleLbl.text = "Sector 3"
                       return cell!
        }
        else if(indexPath.row == 2){
             let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
                       
                       cell?.cellImageView.image = UIImage(named: "home")
                       cell?.titlelLbl.text = "Address"
                       cell?.subtitleLbl.text = "Sector 3"
                       return cell!
        }
        else if(indexPath.row == 3){
             let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
                       
                       cell?.cellImageView.image = UIImage(named: "home")
                       cell?.titlelLbl.text = "Address"
                       cell?.subtitleLbl.text = "Sector 3"
                       return cell!
        }
        
        
        return cell!
    }
    
    
}
