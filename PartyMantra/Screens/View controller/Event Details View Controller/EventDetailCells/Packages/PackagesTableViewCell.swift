//
//  PackagesTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit



class PackagesTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource,GetHeightProtocol
{
   

     var dataCount : Array<Any> = []
    var heightOfCell : CGFloat = 0.0
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
    
    func getHeightOfCell(height: CGFloat) {
        self.heightOfCell = height
    }
       
    
    
    
    func configurePackageCell(modal:EventlistModel) -> Void {
               //self.dataCount = modal.covers  as? [EventCoversDetailModal] ?? []
               
              self.dataCount = modal.packages  as? [EventPackagesDetailModal] ?? []
                self.cellTableView.reloadData()
           }
           
           
           func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.dataCount.count
           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if self.dataCount.count>0{
                    var cell: ViewMoreTableViewCell! = cellTableView.dequeueReusableCell(withIdentifier: "ViewMoreTableViewCell") as? ViewMoreTableViewCell
                    if cell == nil {
                        cellTableView.register(UINib(nibName: "ViewMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewMoreTableViewCell")
                        cell = cellTableView.dequeueReusableCell(withIdentifier: "ViewMoreTableViewCell") as? ViewMoreTableViewCell
                    }
                    
                    if self.dataCount.count>0{
                        cell.heightDelegate = self
                        let cellModal = self.dataCount[indexPath.row] as! EventPackagesDetailModal
                        print(cellModal.activemenus.count)
                        cell.setUpCellCollectionView(modal: cellModal)
                  
                
                
                }
                    
                    
                    return cell
                
            }else{
                var cell: ViewMoreTableViewCell! = cellTableView.dequeueReusableCell(withIdentifier: "ViewMoreTableViewCell") as? ViewMoreTableViewCell
                if cell == nil {
                    cellTableView.register(UINib(nibName: "ViewMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewMoreTableViewCell")
                    cell = cellTableView.dequeueReusableCell(withIdentifier: "ViewMoreTableViewCell") as? ViewMoreTableViewCell
                }
                
              
                
                return cell
            }
            
           
           }
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let cellModal = dataCount[indexPath.row] as! EventPackagesDetailModal
            print(cellModal.activemenus.count)
            if ((cellModal.activemenus.count ?? 0)>0){
                return CGFloat(self.heightOfCell)
             }else{
                return 0
            }
            return 0
           }
       

}
