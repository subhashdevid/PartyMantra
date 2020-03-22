//
//  PackagesTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class PackagesTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource
{

     var dataCount : Array<Any> = []
    @IBOutlet weak var cellIconImage: UIImageView!
    @IBOutlet weak var cellTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellIconImage.image = Utility().SetSVGImage("bag.svg")
        cellIconImage.image = cellIconImage.image?.imageWithColor(color1: .red)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configurePackageCell(modal:EventlistModel) -> Void {
               //self.dataCount = modal.covers  as? [EventCoversDetailModal] ?? []
               
              self.dataCount = modal.covers  as? [EventCoversDetailModal] ?? []
               
               self.cellTableView.reloadData()
           }
           
           
           func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.dataCount.count
           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if self.dataCount.count>0{
                if indexPath.row == 0{
                    var cell: CoverTableViewCell! = cellTableView.dequeueReusableCell(withIdentifier: "CoverTableViewCell") as? CoverTableViewCell
                    if cell == nil {
                        cellTableView.register(UINib(nibName: "CoverTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverTableViewCell")
                        cell = cellTableView.dequeueReusableCell(withIdentifier: "CoverTableViewCell") as? CoverTableViewCell
                    }
                    
                   if self.dataCount.count>0{
                    let cellModal = self.dataCount[indexPath.row] as! EventCoversDetailModal
                    cell.configureCoverChargesCellView(modal: cellModal)
                    }
                    
                    
                    return cell
                }else{
                    var cell: ViewMoreTableViewCell! = cellTableView.dequeueReusableCell(withIdentifier: "ViewMoreTableViewCell") as? ViewMoreTableViewCell
                    if cell == nil {
                        cellTableView.register(UINib(nibName: "ViewMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewMoreTableViewCell")
                        cell = cellTableView.dequeueReusableCell(withIdentifier: "ViewMoreTableViewCell") as? ViewMoreTableViewCell
                    }
                    
                    if self.dataCount.count>0{
                        let cellModal = self.dataCount[indexPath.row] as! EventCoversDetailModal
                        cell.setUpCellCollectionView(modal: cellModal)
                    }
                    
                    
                    return cell
                }
               
            }else{
                var cell: ViewMoreTableViewCell! = cellTableView.dequeueReusableCell(withIdentifier: "ViewMoreTableViewCell") as? ViewMoreTableViewCell
                if cell == nil {
                    cellTableView.register(UINib(nibName: "ViewMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewMoreTableViewCell")
                    cell = cellTableView.dequeueReusableCell(withIdentifier: "ViewMoreTableViewCell") as? ViewMoreTableViewCell
                }
                
                if self.dataCount.count>0{
                    let cellModal = self.dataCount[indexPath.row] as! EventCoversDetailModal
                    cell.setUpCellCollectionView(modal: cellModal)
                }
                
                
                return cell
            }
           
           }
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             if self.dataCount.count>0{
                
                return UITableView.automaticDimension
                
             }else{
                return 0
            }
            return 0
           }
       

}
