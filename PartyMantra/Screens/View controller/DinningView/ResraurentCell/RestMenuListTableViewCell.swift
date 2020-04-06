//
//  RestMenuListTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class RestMenuListTableViewCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
   
    
    @IBOutlet weak var cellView: UIView!
    var dataArr : Array<RestaurantMenus> = []
    @IBOutlet weak var listTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureMenuDetails(dataModal:restaurantModel?) -> Void {
        self.dataArr = dataModal?.menus ?? []
        self.listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        var cell: MenuDetailTableViewCell! = listTableView.dequeueReusableCell(withIdentifier: "MenuDetailTableViewCell") as? MenuDetailTableViewCell
        if cell == nil {
            listTableView.register(UINib(nibName: "MenuDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuDetailTableViewCell")
            cell = listTableView.dequeueReusableCell(withIdentifier: "MenuDetailTableViewCell") as? MenuDetailTableViewCell
        }
        
        let dataModal = self.dataArr[indexPath.row] as? RestaurantMenus
        
        let url = URL(string: dataModal?.image ?? "")
        cell.menuImageIcon.contentMode = .scaleToFill
        cell.menuImageIcon.kf.setImage(with: url, placeholder: nil)
        cell.menuTitleLabel.text = dataModal?.name ?? ""
        cell.menuPricelabel.text = "\(dataModal?.price ?? 0)" ?? "0"
        
        
        return cell
        
       }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 80
    }
    
}
