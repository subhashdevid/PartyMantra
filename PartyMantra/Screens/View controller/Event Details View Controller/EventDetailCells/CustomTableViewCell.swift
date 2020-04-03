//
//  CustomTableViewCell.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Cosmos
class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerimgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var startLbl: UILabel!
    
    @IBOutlet weak var rateView: CosmosView!

    
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
       
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var reviewbtn: UIButton!

    

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
        
        if modal.type == "restaurant" {
            bannarTitle.text = modal.name ?? ""
            bannarSubTitle.text = modal.partner?.name ?? ""
             locTitle.text = modal.name ?? ""
             locSubTitle.text = modal.short_address ?? ""
             DateTitle.text = "Date and Time"
             startDateLbl.text = "\(modal.open ?? "") - \(modal.close ?? "")"
                //modal.open ?? ""
            endDateLbl.text = ""
        }
        else{
            bannarTitle.text = modal.title ?? ""
            bannarSubTitle.text = modal.partner?.name ?? ""
             locTitle.text = modal.venue_name ?? ""
             locSubTitle.text = modal.venue_adderss ?? ""
             DateTitle.text = "Date and Time"
             startDateLbl.text = modal.startdate ?? ""
            endDateLbl.text = modal.enddate ?? ""
        }
        
        rateView.settings.fillMode = .half
        if modal.avgEventreviews.count > 0 {
            let rate = modal.avgEventreviews[0]
            let value = Double(rate.rating ?? "0.0")
            rateView.rating = value ?? 0.0
        }
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
      
        
        if modal.type == "restaurant" {
            addressTitleLbl.text = "Address"
                  addressSubTitleLbl.text = modal.address ?? ""
                  let kms = Double((modal.away ?? 0))
                            
                            distancelbl.text = "\(kms/1000) km away maps Navigation"
                                  distancelbl.lineBreakMode = .byWordWrapping
                                  distancelbl.numberOfLines = 2
        }
        else{
            addressTitleLbl.text = "Address"
                  addressSubTitleLbl.text = modal.venue_adderss ?? ""
            let kms = Double((modal.away ?? 0))
            
            distancelbl.text = "\(kms/1000) km away maps Navigation"
                  distancelbl.lineBreakMode = .byWordWrapping
                  distancelbl.numberOfLines = 2
        }
    }

}

