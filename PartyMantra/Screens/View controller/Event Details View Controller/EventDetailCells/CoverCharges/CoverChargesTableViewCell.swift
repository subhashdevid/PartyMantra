//
//  CoverChargesTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CoverChargesTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var coverChargeTableView: UITableView!
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var coverChargesLbl: UILabel!
    var counter = 0
    
    var dataCount : Array<Any> = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 10
        cellView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
        // Configure the view for the selected state
    }
    
    @objc func addCoverAction( sender : UIButton)  {
        print("add btn pressed")
        let model = self.dataCount[sender.tag] as! EventCoversDetailModal
        if model.packageCount ?? 0 <= 5 {
            model.packageCount = (model.packageCount ?? 0) + 1
        }
        else {
            model.packageCount = model.packageCount ?? 0 + 0
        }
        guard let cell = sender.superview?.superview?.superview?.superview?.superview as? CoverTableViewCell else {
            return
        }
        cell.countLbl.text = "\(model.packageCount ?? 0)"
    }
    
    @objc func minusCoverAction(sender : UIButton)  {
        print("minus btn pressed")
        
        let model = self.dataCount[sender.tag] as! EventCoversDetailModal
        if model.packageCount ?? 0 <= 0 {
            model.packageCount = (model.packageCount ?? 0) - 0
        }
        else {
            model.packageCount = (model.packageCount ?? 0) - 1
        }
        guard let cell = sender.superview?.superview?.superview?.superview?.superview as? CoverTableViewCell else {
            return
        }
        cell.countLbl.text = "\(model.packageCount ?? 0)"
    }
    
    
    func configureMoreInfoCell(modal:EventlistModel) -> Void {
        self.dataCount = modal.covers  as? [EventCoversDetailModal] ?? []
        
        self.coverChargeTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CoverTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CoverTableViewCell") as? CoverTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "CoverTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverTableViewCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "CoverTableViewCell") as? CoverTableViewCell
        }
        
        if self.dataCount.count>0{
            let cellModal = self.dataCount[indexPath.row] as! EventCoversDetailModal
            cell.configureCoverChargesCellView(modal: cellModal)
        }
        
        cell.addIconBtn.addTarget(self, action: #selector(addCoverAction(sender:)), for: .touchUpInside)
        cell.addIconBtn.tag = indexPath.row
        cell.minusBtn.addTarget(self, action: #selector(minusCoverAction(sender:)), for: .touchUpInside)
        cell.minusBtn.tag = indexPath.row
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
}
