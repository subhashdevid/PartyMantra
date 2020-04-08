//
//  GalleryCollectionViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 08/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var cellImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellImage.contentMode = .scaleToFill
    }
}
