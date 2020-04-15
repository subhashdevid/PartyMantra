//
//  LoginViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 19/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import SwiftPhoneNumberFormatter

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtMobile: PhoneFormattedTextField!
    @IBOutlet weak var btnLogin: UIButton!
  
    var validation = Validation()
    
    var mobileNumber = ""
    var rawMobileNumber = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "ViewBGColor")
        
        txtMobile.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "### ###-##-##")
        txtMobile.prefix = nil
        self.txtMobile.textDidChangeBlock = { field in
            if let text = field?.text, text != "" {
                print(text)
                self.mobileNumber = text
            } else {
                print("No text")
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
   
    func validateUser()  {
        self.rawMobileNumber = self.mobileNumber
        
        self.mobileNumber = self.mobileNumber.replacingOccurrences(of: "-", with: "")
        self.mobileNumber = self.mobileNumber.replacingOccurrences(of: " ", with: "")

        
        
        let isValidPhone = Validation.validaPhoneNumber(phoneNumber: self.mobileNumber)
        if isValidPhone {
            self.loginUser(phone: self.mobileNumber )
        }
        else{
            self.showAlert("Please enter 10 digit mobile number")
        }
    }
    
    
    func loginUser(phone : String?) {
        let param: [String: Any] = [
            "mobile": phone ?? ""
        ]
        
        Loader.showHud()
        NetworkManager.LoginUser(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                self?.redirectToOTP()
            case .failure: break
            }
            
        }
    }
    
    func redirectToOTP() {

        let vc = OTPViewController.instantiate(appStoryboard: .events) as OTPViewController
        vc.mobile = self.rawMobileNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func loginClicked() {
        self.view.endEditing(true)
        self.validateUser()
    }
    
}
