//
//  EnterContactDetailsTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 29/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class EnterContactDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var mobileNoFld: UITextField!
    @IBOutlet weak var emailIdFld: UITextField!
    @IBOutlet weak var nameTextFld: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
