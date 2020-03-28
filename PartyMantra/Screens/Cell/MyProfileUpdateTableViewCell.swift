//
//  MyProfileUpdateTableViewCell.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 27/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class MyProfileUpdateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoEditImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var fulladressLabel: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var adressView: UIView!
    @IBOutlet weak var logoImageButton: UIButton!
    @IBOutlet weak var dropdownButton: UIButton!

    @IBOutlet weak var imgDropdown: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
