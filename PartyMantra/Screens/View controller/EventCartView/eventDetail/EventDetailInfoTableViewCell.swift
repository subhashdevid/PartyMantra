//
//  EventDetailInfoTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 29/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class EventDetailInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var dateDurationLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var dateAndTimeTitleLbl: UILabel!
    @IBOutlet weak var addressTitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCheckoutCell(checkOutModal:OrderCheckoutModel?,orderModal:OrderDetaillistModel?){
        
        eventTitleLabel.text = orderModal?.title
        dateDurationLabel.text = checkOutModal?.date
        dateAndTimeLabel.text = orderModal?.order_date
        addressTitleLbl.text = "Address"
        venueLabel.text = orderModal?.details[0].entity?.venue_adderss
        dateAndTimeTitleLbl.text = "Date and Time."
        let urlString = checkOutModal?.image ?? ""
       
        GlobalFunction.shared.downloadImage(imageView: eventImageView, urlStr: urlString )
      
       
        
    }
    
    
}
