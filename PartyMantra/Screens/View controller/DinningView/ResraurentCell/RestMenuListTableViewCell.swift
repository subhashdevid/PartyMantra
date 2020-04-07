//
//  RestMenuListTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class RestMenuListTableViewCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
   
    let count = 0
    @IBOutlet weak var cellView: UIView!
    var dataArr : Array<RestaurantMenuList> = []
    @IBOutlet weak var listTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureMenuDetails(dataModal:RestaurantInfoModel?) -> Void {
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
        
        let dataModal = self.dataArr[indexPath.row]
        let url = URL(string: dataModal.image ?? "")
        cell.menuImageIcon.contentMode = .scaleToFill
        cell.menuImageIcon.kf.setImage(with: url, placeholder: nil)
        cell.menuTitleLabel.text = dataModal.name ?? ""
        cell.menuPricelabel.text = "\(dataModal.price ?? 0)"
        cell.addBtn.tag = indexPath.row
        cell.minusBtn.tag = indexPath.row
        
        cell.addBtn.addTarget(self, action: #selector(addMenuItemAction(sender:)), for: .touchUpInside)
        cell.minusBtn.addTarget(self, action: #selector(minusMenuItemAction(sender:)), for: .touchUpInside)
       
        return cell
        
       }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 80
    }
    
    
    @objc func minusMenuItemAction(sender : UIButton)  {
        let model = self.dataArr[sender.tag]
        if (model.itemCount ?? 0) <= 0 {
            model.itemCount = (model.itemCount ?? 0) - 0
        }
        else {
            model.itemCount = (model.itemCount ?? 0) - 1
        }
        guard let cell = sender.superview?.superview?.superview?.superview as? MenuDetailTableViewCell else {
            return
        }
        cell.countLabel.text = "\(model.itemCount ?? 0)"
    }
    
    
    @objc func addMenuItemAction(sender : UIButton)  {
        let model = self.dataArr[sender.tag]
        if (model.itemCount ?? 0) <= 5 {
            model.itemCount = (model.itemCount ?? 0) + 1
        }
        else {
            model.itemCount = (model.itemCount ?? 0) + 0
        }
        guard let cell = sender.superview?.superview?.superview?.superview as? MenuDetailTableViewCell else {
            return
        }
        cell.countLabel.text = "\(model.itemCount ?? 0)"
    }
       
}
