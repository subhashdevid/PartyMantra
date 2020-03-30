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
    @IBOutlet weak var errorLbl: UILabel!
    
    var amount = ""
    var pay = PaymentViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMoneyButton.addTarget(self, action: #selector(addMoney), for: .touchUpInside)
        self.view.backgroundColor = .white
        self.title="Add Money"
        self.navigationController?.navigationBar.topItem?.title = " "
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setUpUI() -> Void {
        errorLbl.isHidden = true
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
        
        
        amountOnethousandButton.addTarget(self, action: #selector(add1000Money), for: .touchUpInside)
        amountTwothousandButton.addTarget(self, action: #selector(add2000Money), for: .touchUpInside)
        amountThreethousandButton.addTarget(self, action: #selector(add3000Money), for: .touchUpInside)

    }
    
    @objc func addMoney(){
        amountTextField.resignFirstResponder()
        if (amount == ""){
            errorLbl.isHidden = false
            errorLbl.text = "Please enter any amount !!"
            errorLbl.textColor = .red
        }
        else{
            errorLbl.isHidden = true
            getAddMoney()
            
            
        //showAlert(title: "Message", "Money Added...", goBack: false)
            //let Vc = PaymentViewController.instantiate(appStoryboard: .home) as PaymentViewController
            //self.navigationController?.pushViewController(Vc, animated: true)
        }
        
    }
    
    @objc func add1000Money(){
        amountTextField.text = "1000"
        amount =  amountTextField.text ?? ""

        amountTextField.resignFirstResponder()
        
        
        if (amount == ""){
            errorLbl.isHidden = false
            errorLbl.text = "Please enter any amount !!"
            errorLbl.textColor = .red
        }
        else{
            errorLbl.isHidden = true
        }
        
    }
    
    @objc func add2000Money(){
        
        amountTextField.text = "2000"
        amount =  amountTextField.text ?? ""
        amountTextField.resignFirstResponder()
        if (amount == ""){
            errorLbl.isHidden = false
            errorLbl.text = "Please enter any amount !!"
            errorLbl.textColor = .red
        }
        else{
            errorLbl.isHidden = true
        }
        
    }
    @objc func add3000Money(){
        amountTextField.text = "3000"
        amount =  amountTextField.text ?? ""

        amountTextField.resignFirstResponder()
        
        
        if (amount == ""){
            errorLbl.isHidden = false
            errorLbl.text = "Please enter any amount !!"
            errorLbl.textColor = .red
        }
        else{
            errorLbl.isHidden = true
        }
        
    }
    
    
    
    func getAddMoney()  {
        
        let vc = PaymentViewController.instantiate(appStoryboard: .home) as PaymentViewController
        vc.paymentAmount = amount
        self.navigationController?.pushViewController(vc, animated: true)
        
//
//        let param: [String: String] = [
//            "amount" : amountTextField.text ?? ""
//        ]
//        // Loader.showHud()
//
//        Multipart().saveDataUsingMultipart(mainView: self.view, urlString: Server.shared.addMoneyUrl, parameter: param as? [String : String], handler: { (response, isSuccess) in
//
//            if isSuccess{
//               //_ = response as! Dictionary<String,Any>
//
//                //let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                //appDelegate.showHomeScreen()
//
//
//
//            }
//        })
    }
    
    
}


extension AddBalanceViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        amount = textField.text ?? ""
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxCharacters = 4
        
        guard !string.isEmpty else {
            // Backspace detected, allow text change, no need to process the text any further
            return true
        }
        
        // Input Validation
        // Prevent invalid character input, if keyboard is numberpad
        if textField.keyboardType == .numberPad {
            
            // Check for invalid input characters
            if !(CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string))) {
                // Present alert so the user knows what went wrong
                showAlert(title: "Message", "This field accepts only numeric entries.", goBack: false)
                
                // Invalid characters detected, disallow text change
                return false
            }
            errorLbl.isHidden = true
            
        }
        
        // Length Processing
        // Need to convert the NSRange to a Swift-appropriate type
        if let text = textField.text, let range = Range(range, in: text) {
            
            let proposedText = text.replacingCharacters(in: range, with: string)
            
            // Check proposed text length does not exceed max character count
            guard proposedText.count <= maxCharacters else {
                
                // Present alert if pasting text
                // easy: pasted data has a length greater than 1; who copy/pastes one character?
                if string.count > 1 {
                    
                    showAlert(title: "Message", "Paste failed: Maximum character count exceeded.", goBack: false)
                }
                
                // Character count exceeded, disallow text change
                return false
            }
            
            // Only enable the OK/submit button if they have entered all numbers for the last four
            // of their SSN (prevents early submissions/trips to authentication server, etc)
            //            answerButton.isEnabled = (proposedText.count == 4)
        }
        
        // Allow text change
        return true
    }
}
