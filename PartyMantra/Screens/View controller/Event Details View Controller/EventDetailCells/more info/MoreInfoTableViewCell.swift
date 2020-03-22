//
//  MoreInfoTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class MoreInfoTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var moreInfoLbl: UILabel!
     @IBOutlet weak var infoTableView: UITableView!
    
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
    
    
    func configureMoreInfoCell(modal:EventlistModel) -> Void {
        self.dataCount = modal.facilities  as? [EventFacilitiesDetailModal] ?? []
        
        self.infoTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell: moreSubTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "moreSubTableViewCell") as? moreSubTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "moreSubTableViewCell", bundle: nil), forCellReuseIdentifier: "moreSubTableViewCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "moreSubTableViewCell") as? moreSubTableViewCell
        }
        
        if self.dataCount.count>0{
        let cellModal = self.dataCount[indexPath.row] as! EventFacilitiesDetailModal
        cell.configureCellInfoDetail(modal: cellModal)
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
