//
//  RestBannerTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class RestBannerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: AutoScrollingCollectionView!
    
    var bannerModel : [RestaurantEventparty]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
     self.collectionView.register(UINib(nibName: "RestImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RestImageCollectionViewCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(model:RestaurantInfoModel?) {
        bannerModel = model?.eventparty
        collectionView.reloadData()
        collectionView.alwaysBounceHorizontal = true
        collectionView.startScrolling()
    }
    
}
 


extension RestBannerTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Constants.windowWidth, height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : RestImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestImageCollectionViewCell", for: indexPath) as! RestImageCollectionViewCell

       
        let imgBanner = self.bannerModel?[indexPath.row].doc_path ?? ""
        let url : URL = NSURL(string: imgBanner)! as URL

       
        // this downloads the image asynchronously if it's not cached yet
        cell.cellImageIcon.kf.setImage(with: url, placeholder: UIImage(named: "applogo_1024"))
            
        cell.backgroundColor = .red
        
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    

   
    
}


