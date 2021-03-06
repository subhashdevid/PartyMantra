//
//  PackageCheckoutTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 29/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class PackageCheckoutTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var totalPassLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var cellTableView: UITableView!
    
    var type: String?
    
    var dictArr : Array<Dictionary<String,AnyObject>> = []
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellTableView.isScrollEnabled = false
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func getPackageDetails(data:Dictionary<String,AnyObject>) -> Void {
        let dict = data["data"] as? Dictionary<String,AnyObject> ?? [:]
        self.dictArr = dict["packages"] as? Array<Dictionary<String,AnyObject>> ?? []
        if self.type == "party" || self.type == "restaurant" {
            totalPassLbl.text = "\(dict["totalitems"]as? Int ?? 0)"
        }else{
            totalPassLbl.text = "\u{20B9}\(dict["totalpass"]as? Int ?? 0)"
            
        }
        totalAmountLbl.text = "\u{20B9}\(dict["subtotal"]as? Int ?? 0)"
        
        self.cellTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: selectedPackageTableViewCell! = cellTableView.dequeueReusableCell(withIdentifier: "selectedPackageTableViewCell") as? selectedPackageTableViewCell
        if cell == nil {
            cellTableView.register(UINib(nibName: "selectedPackageTableViewCell", bundle: nil), forCellReuseIdentifier: "selectedPackageTableViewCell")
            cell = cellTableView.dequeueReusableCell(withIdentifier: "selectedPackageTableViewCell") as? selectedPackageTableViewCell
        }
        let dict = dictArr[indexPath.row] as? Dictionary<String,AnyObject> ?? [:]
        
        //        if self.type == "party" {
        //            cell.itemName.text = "\(dict["name"] as? String ?? "")"
        ////            print("\(dict["pass"] as? Int ?? 0)")
        //            cell.passLabel.text = "\(dict["quantity"] as? String ?? "")"
        //            cell.amountLabel.text = "\(dict["price"] as? Int ?? 0)"
        //        }
        //        else{
        //            cell.itemName.text = "\(dict["package"] as? String ?? "")"
        ////            print("\(dict["pass"] as? Int ?? 0)")
        //            cell.passLabel.text = "\(dict["pass"] as? String ?? "")"
        //            cell.amountLabel.text = "\(dict["price"] as? Int ?? 0)"
        //        }
        
        if dict.keys.contains("name") {
            cell.itemName.text = "\(dict["name"] as? String ?? "")"
        }
        if dict.keys.contains("package") {
            cell.itemName.text = "\(dict["package"] as? String ?? "")"
        }
        
        if dict.keys.contains("quantity") {
            cell.passLabel.text = "\(dict["quantity"] as? String ?? "")"
        }
        if dict.keys.contains("pass") {
            cell.passLabel.text = "\(dict["pass"] as? String ?? "")"
        }
        if dict.keys.contains("price") {
            cell.amountLabel.text = "\u{20B9}\(dict["price"] as? Int ?? 0)"
        }
        
        return cell
    }
    
}
