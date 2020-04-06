//
//  AboutTableViewCell.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 06/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titlelLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
