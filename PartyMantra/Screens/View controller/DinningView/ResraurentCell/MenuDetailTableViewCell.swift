//
//  MenuDetailTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class MenuDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var menuPricelabel: UILabel!
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var menuImageIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
