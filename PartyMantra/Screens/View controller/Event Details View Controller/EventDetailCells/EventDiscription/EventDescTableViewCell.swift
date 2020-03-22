//
//  EventDescTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class EventDescTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageIcon: UIImageView!
    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellDetailLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
        cellView.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
        // Configure the view for the selected state
    }
    
    func configureCellEventDescView(modal:EventlistModel) -> Void {
        cellImageIcon.image = Utility().SetSVGImage("event.svg")
        cellImageIcon.image = cellImageIcon.image?.imageWithColor(color1: .darkGray)
        cellTitleLbl.text = "Event Description"
        cellDetailLable.text = modal.description
    }
    
}
