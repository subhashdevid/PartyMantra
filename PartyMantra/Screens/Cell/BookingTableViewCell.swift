//
//  BookingTableViewCell.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 08/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class BookingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var crossImgView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol TimeCollectionCellDelegate: class {
    func didTimeSlotCellPressed(timeStr: String)
}

class TimeCollectionCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timeSlotCollectionView: UICollectionView!
       
    var selected_row : Int?
    var timeArray = [String]()
    weak var timeCell_delegate:TimeCollectionCellDelegate?


       override func awakeFromNib() {
           super.awakeFromNib()
        timeSlotCollectionView.delegate = self
        timeSlotCollectionView.dataSource = self
       }
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
    }
    
    func cellPressAction(timeStr : String) {
        if let del = self.timeCell_delegate {
            del.didTimeSlotCellPressed(timeStr: timeStr)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "TimeSlotCollectionViewCell", for: indexPath) as? TimeSlotCollectionViewCell
       
        if indexPath.row == self.selected_row {
            cell?.titleLbl.backgroundColor = .systemPink
            cell?.titleLbl.textColor = .white

        }else{
            cell?.titleLbl.backgroundColor = .white
            cell?.titleLbl.textColor = .purple
        }
        cell?.titleLbl.text = self.timeArray[indexPath.row]
        return cell!
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selected_row = indexPath.row

        cellPressAction(timeStr: self.timeArray[indexPath.row])
        self.timeSlotCollectionView.reloadData()
        
    }
    
  
   
}


class TimeSlotCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.backgroundColor = .white
    }
}


class StackTableViewCell: UITableViewCell {

    @IBOutlet weak var menView: UIView!
    @IBOutlet weak var womenView: UIView!
    @IBOutlet weak var coupleView: UIView!
    
    @IBOutlet weak var plusBtnMen: UIButton!
    @IBOutlet weak var minusBtnMen: UIButton!

    @IBOutlet weak var plusBtnWomen: UIButton!
    @IBOutlet weak var minusBtnWomen: UIButton!

    @IBOutlet weak var plusBtnCouple: UIButton!
    @IBOutlet weak var minusBtnCouple: UIButton!

    @IBOutlet weak var menCount: UILabel!
    @IBOutlet weak var womenCount: UILabel!
    @IBOutlet weak var coupleCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

import FSCalendar

class CalenderTableViewCell: UITableViewCell {

    @IBOutlet weak var fscalender: FSCalendar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
