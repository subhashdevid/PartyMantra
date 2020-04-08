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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class TimeCollectionCell: UITableViewCell {
    @IBOutlet weak var timeSlotCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
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
