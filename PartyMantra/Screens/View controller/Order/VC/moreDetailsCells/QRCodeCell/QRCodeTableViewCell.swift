//
//  QRCodeTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 01/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class QRCodeTableViewCell: UITableViewCell {

    @IBOutlet weak var qrCodeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
