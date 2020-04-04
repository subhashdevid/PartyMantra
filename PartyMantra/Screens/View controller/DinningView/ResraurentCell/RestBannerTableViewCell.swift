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
    
     var imageData = [HomeBanners]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(RestImageCollectionViewCell.self, forCellWithReuseIdentifier: "RestImageCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(imgData:[HomeBanners]) {
        imageData = imgData
        collectionView.reloadData()
        collectionView.startScrolling()
    }
    
}
 



extension RestBannerTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
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
        cell.backgroundColor = .red
        
       // let imgBanner = self.imageData[indexPath.row]
       // let url = URL(string: imgBanner.image ?? "")
        
       // cell.cellImageIcon.kf.setImage(with: url, placeholder: nil)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

