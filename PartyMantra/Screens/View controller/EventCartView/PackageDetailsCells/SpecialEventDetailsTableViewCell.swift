//
//  SpecialEventDetailsTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 30/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class SpecialEventDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var ratio: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configureSpecialDetail(modal:OrderCheckoutModel?) -> Void {
        
        name.text = modal?.name
        email.text = modal?.email
        mobile.text = modal?.mobile
        ratio.text = modal?.ratio
        
    }
    
}
