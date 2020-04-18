//
//  PackagesTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

protocol GetFinalHeightOfCell {
    func getHeightFromArr(height:Int,restCellHeight:Int,isViewMoreBtnClicked:Bool,indexInt:Int) -> Void
}

class PackagesTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource
{
   
    var heightDelegate : GetFinalHeightOfCell?
    var heightArr : [Int] = []
     var dataCount : Array<Any> = []
    var senderInt = 0
    var heightOfCell = 0
    var newHeight = 0
    var isViewMoreClicked : Bool = false
    @IBOutlet weak var cellIconImage: UIImageView!
    @IBOutlet weak var cellTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellIconImage.image = UIImage.init(named: "bagIcon")
        cellIconImage.image = cellIconImage.image?.imageWithColor(color1: .black)
        // Initialization code
        cellTableView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    @objc func addCoverAction( sender : UIButton)  {
          print("add btn pressed")
          let model = self.dataCount[sender.tag] as! EventPackagesDetailModal
          if model.packageCount ?? 0 <= 5 {
              model.packageCount = (model.packageCount ?? 0) + 1
          }
          else {
              model.packageCount = model.packageCount ?? 0 + 0
          }
        guard let cell = sender.superview?.superview?.superview?.superview?.superview?.superview as? ViewMoreTableViewCell else {
              return
          }
          cell.countLbl.text = "\(model.packageCount ?? 0)"
      }
      
    @objc func minusCoverAction(sender : UIButton)  {
        print("minus btn pressed")
        
        let model = self.dataCount[sender.tag] as! EventPackagesDetailModal
        if model.packageCount ?? 0 <= 0 {
            model.packageCount = (model.packageCount ?? 0) - 0
        }
        else {
            model.packageCount = (model.packageCount ?? 0) - 1
        }
        guard let cell = sender.superview?.superview?.superview?.superview?.superview?.superview as? ViewMoreTableViewCell else {
            return
        }
        cell.countLbl.text = "\(model.packageCount ?? 0)"
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
                    
            cell.addIconBtn.addTarget(self, action: #selector(addCoverAction(sender:)), for: .touchUpInside)
                                  cell.addIconBtn.tag = indexPath.row
                                  cell.minusBtn.addTarget(self, action: #selector(minusCoverAction(sender:)), for: .touchUpInside)
                                  cell.minusBtn.tag = indexPath.row
                
                
                cell.viewMoreBtn.tag = indexPath.row
                cell.viewMoreBtn.addTarget(self, action: #selector(isViewMoreBtnClicked(sender:)), for: .touchUpInside)
                    if self.dataCount.count>0{
                        
                        let cellModal = self.dataCount[indexPath.row] as! EventPackagesDetailModal
                        cell.cellDetailLabel.text = cellModal.custom_package_detail
                        print(cellModal.activemenus.count)
                        cell.setUpCellCollectionView(modal: cellModal, index: indexPath.row)
                   
                        
                        self.heightOfCell = Utility().heightForView(text: cellModal.custom_package_detail ?? "", font: 12.0, width: cell.collectionCellView.frame.size.width-10 )
                        cell.cellDetailLabel.frame = CGRect(x: 0, y: 0, width: Int(size.width), height: self.heightOfCell+40)
                       
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
            
           
            if ((self.isViewMoreClicked) && (indexPath.row == self.senderInt)){
                return CGFloat(self.newHeight)
             }else{
                return CGFloat(self.heightOfCell+100)
            }
            return 0
           }
    
    
    
    
    
    @objc func isViewMoreBtnClicked(sender:UIButton) -> Void {
        self.senderInt = sender.tag
    self.isViewMoreClicked = !self.isViewMoreClicked
    let cellModal = self.dataCount[sender.tag] as! EventPackagesDetailModal
    guard let cell = sender.superview?.superview?.superview as? ViewMoreTableViewCell else {
        return
    }
        let count = Int((cellModal.activemenus.count)/2)
        self.newHeight = (self.heightOfCell+(count*35)+100)
        
        heightDelegate?.getHeightFromArr(height: self.newHeight+68,restCellHeight:self.heightOfCell+100, isViewMoreBtnClicked: self.isViewMoreClicked, indexInt: sender.tag)
       
        self.cellTableView.reloadData()
    }

}
