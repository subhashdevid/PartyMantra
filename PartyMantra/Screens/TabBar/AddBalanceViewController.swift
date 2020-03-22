//
//  AddBalanceViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class AddBalanceViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!

    @IBOutlet weak var amountOnethousandButton: UIButton!
    @IBOutlet weak var amountTwothousandButton: UIButton!
    @IBOutlet weak var amountThreethousandButton: UIButton!
    @IBOutlet weak var addMoneyButton: UIButton!


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.placeholder = "\u{20B9} Amount"
        self.amountTextField.keyboardType=UIKeyboardType.numberPad

        amountOnethousandButton.backgroundColor = .clear
        amountOnethousandButton.setTitle("+ \u{20B9} 1000", for: .normal)
        amountOnethousandButton.layer.cornerRadius = 7
        amountOnethousandButton.layer.borderWidth = 1
        amountOnethousandButton.layer.borderColor = UIColor.blue.cgColor
        
        amountTwothousandButton.backgroundColor = .clear
        amountTwothousandButton.setTitle("+ \u{20B9} 2000", for: .normal)
        amountTwothousandButton.layer.cornerRadius = 7
        amountTwothousandButton.layer.borderWidth = 1
        amountTwothousandButton.layer.borderColor = UIColor.blue.cgColor
        
        amountThreethousandButton.backgroundColor = .clear
        amountThreethousandButton.setTitle("+ \u{20B9} 3000", for: .normal)
        amountThreethousandButton.layer.cornerRadius = 7
        amountThreethousandButton.layer.borderWidth = 1
        amountThreethousandButton.layer.borderColor = UIColor.blue.cgColor

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedPreFilledAmount(sender: UIButton) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
