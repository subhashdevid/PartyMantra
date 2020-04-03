//
//  ReviewTableViewCell.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 03/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var dateLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
