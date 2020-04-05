//
//  AllTaxesTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 30/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class AllTaxesTableViewCell: UITableViewCell {

    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var packageTotalTitle: UILabel!
    @IBOutlet weak var taxedAmountLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureTaxCell(modal:OrderCheckoutModel?) -> Void {
        packageTotalTitle.text = "Platform + Tax"
        totalAmountLbl.text = "\(modal?.amount ?? 0)"
        taxedAmountLbl.text = "\(modal?.taxes ?? 0)"
        
    }
    
    func configureEventTaxCell(dataDict:Dictionary<String,AnyObject>) -> Void {
         let dict = dataDict["data"] as? Dictionary<String,AnyObject> ?? [:]
               
        
        packageTotalTitle.text = "Platform + Tax"
           totalAmountLbl.text = "\(dict["subtotal"]as? Int ?? 0)"
           taxedAmountLbl.text = "\(dict["taxes"]as? Int ?? 0)"
           
       }
    
}
