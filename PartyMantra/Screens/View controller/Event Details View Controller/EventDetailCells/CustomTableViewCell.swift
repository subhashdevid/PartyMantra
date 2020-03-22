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
     @IBOutlet weak var bannarTitle: UILabel!
     @IBOutlet weak var bannarSubTitle: UILabel!
     @IBOutlet weak var locTitle: UILabel!
     @IBOutlet weak var locSubTitle: UILabel!
    @IBOutlet weak var DateTitle: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var endDateLbl: UILabel!
       
    override func awakeFromNib() {
           super.awakeFromNib()
        lowerView.bringSubviewToFront(bannerimgView)
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
   
    func configureGallaryView(modal:EventlistModel) -> Void {
        let url = URL(string: modal.header_image ?? "")
           bannerimgView.contentMode = .scaleAspectFill
           bannerimgView.kf.setImage(with: url, placeholder: nil)
        bannarTitle.text = modal.title ?? ""
        bannarSubTitle.text = modal.partner?.name ?? ""
         locTitle.text = modal.venue_name ?? ""
         locSubTitle.text = modal.venue_adderss ?? ""
         DateTitle.text = "Date and Time"
         startDateLbl.text = modal.startdate ?? ""
        endDateLbl.text = modal.enddate ?? ""
       }

}



class AddressViewCell: UITableViewCell {

   
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var routeImg: UIImageView!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var awayImgIcon: UIImageView!
    
    @IBOutlet weak var addressTitleLbl: UILabel!
    @IBOutlet weak var addressSubTitleLbl: UILabel!
    @IBOutlet weak var distancelbl: UILabel!
    @IBOutlet weak var clickToCallBtn: UIButton!

    override func awakeFromNib() {
           super.awakeFromNib()
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureAddressCell(modal:EventlistModel){
        addressTitleLbl.text = "Address"
        addressSubTitleLbl.text = modal.venue_adderss ?? ""
        distancelbl.text = "\(modal.away ?? 0)"
        
    }

}

