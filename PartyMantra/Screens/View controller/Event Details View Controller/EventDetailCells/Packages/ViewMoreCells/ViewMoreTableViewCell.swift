//
//  ViewMoreTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

protocol GetHeightProtocol{
    func getHeightOfCell(height: CGFloat) -> Void
}

class ViewMoreTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    var heightDelegate : GetHeightProtocol?
    @IBOutlet weak var cellDetailLabel: UILabel!
    @IBOutlet weak var collectionCellView: UIView!
    @IBOutlet weak var viewMoreBtn: UIButton!
    @IBOutlet weak var addIconImg: UIImageView!
    @IBOutlet weak var minusIconImg: UIImageView!
    @IBOutlet weak var addIconBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var cellItemLbl: UILabel!
    @IBOutlet weak var cellCostLabel: UILabel!
    
    
    @IBOutlet weak var cellCollectionView: UICollectionView!
   
     var dataCount : Array<EventPackagesActiveMenuModal> = []
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        addIconBtn.layer.cornerRadius = addIconBtn.frame.size.width/2
               addIconBtn.layer.masksToBounds = true
               addIconBtn.layer.borderWidth = 1
               addIconBtn.layer.borderColor = UIColor.darkGray.cgColor
               
                addIconImg.image = Utility().SetSVGImage("more.svg")
                addIconImg.image = addIconImg.image?.imageWithColor(color1: .red)
                minusIconImg.image = Utility().SetSVGImage("minus.svg")
                minusIconImg.image = minusIconImg.image?.imageWithColor(color1: .red)
               
               minusBtn.layer.cornerRadius = minusBtn.frame.size.width/2
               minusBtn.layer.masksToBounds = true
               minusBtn.layer.borderWidth = 1
               minusBtn.layer.borderColor = UIColor.darkGray.cgColor
               
        
        
        cellCollectionView.register(UINib.init(nibName: "ViewMoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewMoreCollectionViewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setUpCellCollectionView(modal:EventPackagesDetailModal) -> Void {
        print(modal.activemenus.count)
        self.dataCount = modal.activemenus  as? [EventPackagesActiveMenuModal] ?? []
        if self.dataCount.count>0{
            cellDetailLabel.text = modal.custom_package_detail ?? ""
          let height = Utility().heightForView(text: modal.custom_package_detail ?? "", font: 12.0, width: collectionCellView.frame.size.width-10 )
              let totalIndex = Int(Int((self.dataCount.count)/2)*55 )
            if totalIndex>0{
                heightDelegate?.getHeightOfCell(height: CGFloat(totalIndex+height+95))
            }else{
                heightDelegate?.getHeightOfCell(height: CGFloat(0+height+95))
            }
            cellItemLbl.text = "\(modal.package_name) \(modal.text_under_name)"
            cellCostLabel.text = "\(modal.price)"
            countLbl.text = "0"
            
        }
        
        self.cellCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataCount.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        let cell:ViewMoreCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewMoreCollectionViewCell", for: indexPath) as! ViewMoreCollectionViewCell

        if self.dataCount.count>0{
        let cellModal = self.dataCount[indexPath.row] as! EventPackagesActiveMenuModal
        cell.cellColorView.layer.cornerRadius = cell.cellColorView.frame.size.width/2
        cell.cellColorView.layer.masksToBounds = true
            cell.cellTitleLbl.text = cellModal.name
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
         return CGSize(width: size, height: 40)
    }
        
        

}
