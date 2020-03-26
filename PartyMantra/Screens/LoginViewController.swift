//
//  LoginViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 19/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txtMobile: UITextField!
//    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "ViewBGColor")
//        txtMobile.customTextFieldWithLeftImage(leftImage: "MobileIcon")
//        txtPassword.customTextFieldWithLeftImage(leftImage: "PasswordIcon")
        
        txtMobile.addAccessortViewToTextField()
//        txtPassword.addAccessortViewToTextField()
        
//        btnLogin.customButtonForLoginSignUp()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewForScrolling() -> UIScrollView? {
        return scrollView
    }
    
    override func isKeyboardNotificationsEnabled() -> Bool {
        return true
    }
    
    @IBAction func loginClicked() {
        if txtMobile.text?.isValidPhone ?? false {
//            if (txtPassword.text?.count ?? 0) > 0 {
                let param: [String: Any] = [
                    "mobile": txtMobile.text ?? ""//,
//                    "password": txtPassword.text ?? ""
                ]
                Loader.showHud()
                NetworkManager.LoginUser(parameters: param) {[weak self] result in
                    
                    Loader.dismissHud()
                    switch result {
                    case let .success(response):
                        print(response)
//                        if response.statusCode == 200 {
//                            let otpVC = OTPViewController.instantiate(appStoryboard: .main) as! OTPViewController
//                            otpVC.mobile = self?.txtMobile.text
//                            self?.navigationController?.pushViewController(otpVC, animated: true)
                            
//                            if let user = response.data {
                                
//                                let encoder = JSONEncoder()
//                                if let encoded = try? encoder.encode(user) {
//                                    let defaults = UserDefaults.standard
//                                    defaults.set(encoded, forKey: "USER")
//                                }
//                                UserDefaults.standard.set("1", forKey: "ISLOGIN")
//                                UserDefaults.standard.synchronize()
//                                Constants.appDelegate?.showHomeScreen()
//                            }
                            
//                        } else {
//                            self?.showAlert(response.message ?? "")
//                        }
                        
                    case .failure: break
                    }
                    
                }
//            } else {
//                self.showAlert("Please enter password");
//            }
        } else {
            self.showAlert("Please enter 10 digit mobile number")
        }
        
    }
    
    
    
//    @IBAction func registerClicked() {
//        let vc = FillInfoViewController.instantiate(appStoryboard: .main)
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    @IBAction func forgetPasswordClicked() {
//        let vc = ForgetPasswordViewController.instantiate(appStoryboard: .main)
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTF = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == txtMobile {
            txtMobile.becomeFirstResponder()
//        } else {
//            txtPassword.resignFirstResponder()
//        }
        return true
    }
}

