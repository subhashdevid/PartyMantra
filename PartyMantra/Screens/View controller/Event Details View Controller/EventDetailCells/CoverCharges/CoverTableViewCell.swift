//
//  CoverTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CoverTableViewCell: UITableViewCell {

    @IBOutlet weak var addIconImg: UIImageView!
    @IBOutlet weak var minusIconImg: UIImageView!
    @IBOutlet weak var addIconBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var cellItemLbl: UILabel!
    @IBOutlet weak var cellCostLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addIconBtn.layer.cornerRadius = addIconBtn.frame.size.width/2
        addIconBtn.layer.masksToBounds = true
        addIconBtn.layer.borderWidth = 1
        addIconBtn.layer.borderColor = UIColor.darkGray.cgColor
        
         addIconImg.image = UIImage.init(named: "addIcon")
         addIconImg.image?.imageWithColor(color1: .red)
         minusIconImg.image = UIImage.init(named: "minus")
         minusIconImg.image = minusIconImg.image?.imageWithColor(color1: .red)
        
        minusBtn.layer.cornerRadius = minusBtn.frame.size.width/2
        minusBtn.layer.masksToBounds = true
        minusBtn.layer.borderWidth = 1
        minusBtn.layer.borderColor = UIColor.darkGray.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCoverChargesCellView(modal:EventCoversDetailModal) -> Void {
        cellItemLbl.text = modal.package_name
        cellCostLabel.text = "\(modal.price ?? 0)"
        countLbl.text = "\(modal.packageCount ?? 0)"
        
        
        
    }
    
}
