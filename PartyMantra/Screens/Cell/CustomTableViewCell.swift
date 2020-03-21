//
//  CustomTableViewCell.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class GalleryViewCell: UITableViewCell {

   
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var bannerimgView: UIImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
        lowerView.bringSubviewToFront(bannerimgView)
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}



class AddressViewCell: UITableViewCell {

   
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var routeImg: UIImageView!
    @IBOutlet weak var callBtn: UIButton!
    
    @IBOutlet weak var addressTitleLbl: UILabel!
    @IBOutlet weak var addressSubTitleLbl: UILabel!
    @IBOutlet weak var distancelbl: UILabel!

    override func awakeFromNib() {
           super.awakeFromNib()
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

