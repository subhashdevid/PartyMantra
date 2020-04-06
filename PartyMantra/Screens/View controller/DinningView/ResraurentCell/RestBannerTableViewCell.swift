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
    
    var bannerModel : [RestEventparty]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(RestImageCollectionViewCell.self, forCellWithReuseIdentifier: "RestImageCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(model:restaurantModel?) {
        bannerModel = model?.eventparty
        collectionView.reloadData()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RestImageCollectionViewCell.self)", for: indexPath) as? RestImageCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        
        let imgBanner = self.bannerModel?[indexPath.row].doc_path ?? ""
        let url = URL(string: (String(imgBanner) ?? "") )
        
        if url == nil {
            cell.cellImageIcon.kf.setImage(with: url, placeholder: nil)
        }
        
            
        cell.backgroundColor = .red
        
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

