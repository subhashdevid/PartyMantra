//
//  ProfileTableViewCell.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 26/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var disclosureImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var suiTtleLbl: UILabel!
    @IBOutlet weak var titleField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
