//
//  moreSubTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class moreSubTableViewCell: UITableViewCell {

    @IBOutlet weak var cellDetailLbl: UILabel!
    @IBOutlet weak var cellImageIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
        // Configure the view for the selected state
    }
    func configureCellInfoDetail(modal:EventFacilitiesDetailModal) -> Void {
        cellImageIcon.image = Utility().SetSVGImage("correct.svg")
        cellImageIcon.image = cellImageIcon.image?.imageWithColor(color1: .gray)
        cellDetailLbl.text = modal.name
    }
    
}
