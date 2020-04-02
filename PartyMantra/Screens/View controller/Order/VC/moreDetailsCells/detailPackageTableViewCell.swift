//
//  detailPackageTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 01/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class detailPackageTableViewCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var cellTableView: UITableView!
    var packagesData : [CheckoutPackagesModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellTableView.separatorStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCheckoutListTableView(dataModal: OrderCheckoutModel?) -> Void {
        self.packagesData = dataModal?.packages
        self.cellTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.packagesData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: selectedPackageTableViewCell! = cellTableView.dequeueReusableCell(withIdentifier: "selectedPackageTableViewCell") as? selectedPackageTableViewCell
        if cell == nil {
            cellTableView.register(UINib(nibName: "selectedPackageTableViewCell", bundle: nil), forCellReuseIdentifier: "selectedPackageTableViewCell")
            cell = cellTableView.dequeueReusableCell(withIdentifier: "selectedPackageTableViewCell") as? selectedPackageTableViewCell
        }
           
        let package = self.packagesData?[indexPath.row]
        cell.itemName.text = package?.package
        cell.passLabel.text = "\(package?.pass ?? 0) Pass"
        cell.amountLabel.text = "₹ \(package?.price ?? 0)"
        
        return cell
    }
    
}
