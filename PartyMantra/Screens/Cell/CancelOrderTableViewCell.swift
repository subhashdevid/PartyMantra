//
//  CancelOrderTableViewCell.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 02/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit



class CancelOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titlelLbl: UILabel!
    @IBOutlet weak var reasonTextview: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
