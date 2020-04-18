//
//  AboutViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 06/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var topBreadcrum: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var crossbtn: UIButton!
    @IBOutlet weak var submitbtn: UIButton!

    var restModal : RestaurantInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.estimatedRowHeight = 44
        self.tblView.rowHeight = UITableView.automaticDimension
        submitbtn.addTarget(self, action: #selector(dissMissPopUpView), for: .touchUpInside)
        crossbtn.addTarget(self, action: #selector(dissMissPopUpView), for: .touchUpInside)
        self.tblView.reloadData()
    }
    
    @objc func dissMissPopUpView(){
        self.dismiss(animated: true, completion: nil)
    }

}



extension AboutViewController : UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
        
        if(indexPath.row == 0){
             let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
            
            
            
            cell?.cellImageView.image = #imageLiteral(resourceName: "icons8-address-96")
            cell?.titlelLbl.text = "Address"
            cell?.subtitleLbl.text = self.restModal?.short_address
            return cell!

        }
        else if(indexPath.row == 1){
             let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
                       
                       cell?.cellImageView.image = #imageLiteral(resourceName: "time")
                       cell?.titlelLbl.text = "Time"
                       cell?.subtitleLbl.text = self.restModal?.open
                       return cell!
        }
        else if(indexPath.row == 2){
             let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
             cell?.cellImageView.image = #imageLiteral(resourceName: "price")
            cell?.titlelLbl.text = "Average Cost"
            cell?.subtitleLbl.text = self.restModal?.per_person_text
                       return cell!
        }
        else if(indexPath.row == 3){
             let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as? AboutTableViewCell
                       
                       cell?.cellImageView.image = #imageLiteral(resourceName: "phone")
                       cell?.titlelLbl.text = "Contact No."
            cell?.subtitleLbl.text = self.restModal?.contact_no
                       return cell!
        }else{
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "AboutFacilitiesTableViewCell") as? AboutFacilitiesTableViewCell
                cell?.cellIcon.image = #imageLiteral(resourceName: "bagIcon")
                cell?.cellIcon.image = cell?.cellIcon.image?.imageWithColor(color1: .red)
                cell?.cellTitleLbl.text = "Facilities"
            
           
            cell?.setUpFacilitiesCellCollectionView(resModal: self.restModal, index: indexPath.row)
            return cell!
        }
      
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4{
            var count = 0
            if ((Int((restModal?.facilities ?? []).count)))/2 == 0{
                 count = ((Int((restModal?.facilities ?? []).count)))/2
            }else{
                 count = ((Int((restModal?.facilities ?? []).count)+1))/2
            }
            
         return CGFloat((count*41)+10)
        }
        return UITableView.automaticDimension
    }
    
}


class facilitiesCollectionCell:UICollectionViewCell{
    @IBOutlet weak var facilitiesIcon: UIImageView!
    @IBOutlet weak var facilitiesLbl: UILabel!
    
    
    
    
}
