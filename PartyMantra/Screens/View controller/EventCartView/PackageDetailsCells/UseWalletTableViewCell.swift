//
//  UseWalletTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 30/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class UseWalletTableViewCell: UITableViewCell {

    @IBOutlet weak var walletAmountLabel: UILabel!
    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var checkBoxBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWalletOption(data:Dictionary<String,AnyObject>?)->Void{
         let dict = data?["data"] as? Dictionary<String,AnyObject> ?? [:]
        let balance = dict["walletbalance"] as? Int ?? 0
        walletAmountLabel.text = "Use Wallet Balance : ₹ \(balance)"
        
    }
    
}
