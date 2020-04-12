//
//  ReviewTableViewCell.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 03/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var dateLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureReviewCell(reviewModal: ReviewsListModel?){
        dateLbl.text = reviewModal?.created_at
        titlelbl.text = reviewModal?.user?.name
        subTitlelbl.text = reviewModal?.description

        cosmosView.isUserInteractionEnabled = false
        cosmosView.settings.fillMode = .half

        let rate = reviewModal?.rating
        cosmosView.rating = Double(rate ?? Int(0.0))
        
        //let imgBanner = self.imageData[indexPath.row]
        let url = URL(string: reviewModal?.user?.image ?? "")
        bannerImg.kf.setImage(with: url, placeholder: UIImage(named: "applogo_1024"))

    }
    

}

