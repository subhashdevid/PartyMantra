//
//  OTPViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 29/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import DPOTPView


class OTPViewController: BaseViewController {
    
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var txtDPOTPView: DPOTPView!
    
    var otpString : String = ""
    var mobile : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        submitBtn.addTarget(self, action: #selector(submitOTPChange), for: .touchUpInside)
        
        txtDPOTPView.dpOTPViewDelegate = self
        txtDPOTPView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        txtDPOTPView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        txtDPOTPView.fontTextField = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(25.0))!

        
    }

    @objc func submitOTPChange(){
        self.verifyOtp()
    }
    
    func verifyOtp() {
        
        self.mobile = self.mobile?.replacingOccurrences(of: "-", with: "")
        self.mobile = self.mobile?.replacingOccurrences(of: " ", with: "")
        
        
        
        if otpString.count == 6  && self.mobile?.count == 10 {
            self.loginUserWithOtp(otp: otpString, mobile: self.mobile ?? "")
        }else{
        }
    }
    
    func loginUserWithOtp(otp : String?, mobile: String) {
       
           let param: [String: Any] = [
            "mobile": mobile ,
               "otp": otp ?? ""
           ]
           
           Loader.showHud()
           NetworkManager.verifyOTP(parameters: param) {[weak self] result in
               Loader.dismissHud()
               switch result {
               case let .success(response):
                   print(response)
                   UserDefaults.standard.set(response.data?.token, forKey: "AccessToken") //setObject
                   UserDefaults.standard.synchronize()

                   
                   self?.redirectToAddressScreen()
               case .failure: break
               }
           }
       }
    
    
    func redirectToAddressScreen()  {
        
        let vc = LocationSelectViewController.instantiate(appStoryboard: .events) as LocationSelectViewController
        vc.mobile = self.mobile
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension OTPViewController : DPOTPViewDelegate {
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
        otpString = text
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
    }
    func dpOTPViewBecomeFirstResponder() {
        
    }
    func dpOTPViewResignFirstResponder() {
        
    }
}


