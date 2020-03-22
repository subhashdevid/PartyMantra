//
//  ViewMoreTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ViewMoreTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource  {

    @IBOutlet weak var cellCollectionView: UICollectionView!
    @IBOutlet weak var viewMoreBtn: UIButton!
     var dataCount : Array<Any> = []
    override func awakeFromNib() {
        super.awakeFromNib()
        cellCollectionView.register(UINib.init(nibName: "ViewMoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewMoreCollectionViewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setUpCellCollectionView(modal:EventCoversDetailModal) -> Void {
       // self.dataCount = //modal.covers  as? [EventCoversDetailModal] ?? []
        self.cellCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        let cell:ViewMoreCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewMoreCollectionViewCell", for: indexPath) as! ViewMoreCollectionViewCell

        cell.cellColorView.layer.cornerRadius = cell.cellColorView.frame.size.width/2
        cell.cellColorView.layer.masksToBounds = true
        cell.cellTitleLbl.text = "Test text \(indexPath.row)"
           return cell
       }
    

}
