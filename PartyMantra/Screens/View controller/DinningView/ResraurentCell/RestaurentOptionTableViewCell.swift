//
//  RestaurentOptionTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class RestaurentOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var aboutImgIcon: UIImageView!
    @IBOutlet weak var aboutLbl: UILabel!
    
   
       @IBOutlet weak var comboBtn: UIButton!
       @IBOutlet weak var comboImgIcon: UIImageView!
       @IBOutlet weak var comboLbl: UILabel!
       
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var callImgIcon: UIImageView!
    @IBOutlet weak var callLbl: UILabel!
  
    @IBOutlet weak var directionBtn: UIButton!
      @IBOutlet weak var directionImgIcon: UIImageView!
      @IBOutlet weak var directionLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
