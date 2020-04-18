//
//  AboutFacilitiesTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 18/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class AboutFacilitiesTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var facilitiesCollectionView: UICollectionView!
    
    var heughtOfCell = 0
       var indexOfCell = 0
    var dataCount : Array<RestaurantInfoFacilities> = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        facilitiesCollectionView.delegate = self
        facilitiesCollectionView.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
      
       
       func setUpFacilitiesCellCollectionView(resModal:RestaurantInfoModel?,index:Int) -> Void {
            
        self.dataCount = resModal?.facilities as? Array<RestaurantInfoFacilities> ?? []
            self.indexOfCell = index
            self.facilitiesCollectionView.reloadData()
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print("\(self.dataCount.count)")
            return self.dataCount.count
           }
           
           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              
            let cell:facilitiesCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "facilitiesCollectionCell", for: indexPath) as! facilitiesCollectionCell

            if self.dataCount.count>0{
                let cellModal = self.dataCount[indexPath.row] 
            cell.facilitiesIcon.image = #imageLiteral(resourceName: "correct")
            cell.facilitiesLbl.text = cellModal.name
            }
                return cell
           }
        
            
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let noOfCellsInRow = 2
               let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
               let totalSpace = flowLayout.sectionInset.left
                   + flowLayout.sectionInset.right
                   + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
                let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
             return CGSize(width: size, height: 20)
        }
            
            

    }

    

