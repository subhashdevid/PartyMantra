//
//  ProfileViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    var profile : ProfileModel?  //CGSizeMake(self.view.frame.width,self.view.frame.height+100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.contentSize = CGSize(width: self.view.frame.width,height: self.view.frame.height+100)
       // self.fetchUserProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Profile"
        self.tabBarController?.tabBar.isHidden = false
        self.fetchUserProfile()
    }

    
    func fetchUserProfile() {
        let accessUserToken =  UserDefaults.standard.string(forKey: "AccessToken")
        let param: [String: Any] = [
            "token":accessUserToken ?? ""
        ]
        Loader.showHud()
        NetworkManager.getProfile(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                if let userProfile = response.data {
                    self?.profile = userProfile
                    self?.nameLabel.text = self?.profile?.name?.capitalized
                    self?.mobileLabel.text = self?.profile?.mobile
                    self?.emailLabel.text = self?.profile?.email
                    self?.genderLabel.text = "Gender: \(self?.profile?.gender?.capitalized ?? "")"
                        
//
                    self?.dobLabel.text = self?.profile?.dob
                    self?.addressLabel.text = "Address: \(self?.profile?.address?.capitalized ?? "")"
                                    
                    let url = URL(string: userProfile.image ?? "")
                    self?.profileImgView.contentMode = .scaleAspectFill
                    self?.profileImgView.kf.setImage(with: url, placeholder: nil)

                    
                }
                
            case .failure: break
            }
        }
    }
    
    
    
    @IBAction func clickedUpdateProfile() {
        
        //UpdateProfileViewController
        //let vc = UpdateProfileViewController.instantiate(appStoryboard: .home)
               //self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = MyProfileUpdateViewController.instantiate(appStoryboard: .home)
        vc.profile = self.profile
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    

    
    @IBAction func clickedLogout() {
        let alert = UIAlertController(title: "Are you sure you want to logout ?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    
        let OKAction = UIAlertAction(title: "Yes", style: .default, handler: { _ -> Void in
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            UserDefaults.standard.set("0", forKey: "ISLOGIN") //setObject
            UserDefaults.standard.synchronize()
            appDelegate.showLoginScreen()
            
            
        })

    alert.addAction(OKAction)
    self.present(alert, animated: true)
        
    }
    @IBAction func clickedAboutUs() {
        let vc = WebViewController.instantiate(appStoryboard: .home)
        vc.urlStr = "https://www.google.com"
        vc.screenTitle = "About Us"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedPrivacy() {
        let vc = WebViewController.instantiate(appStoryboard: .home)
        vc.urlStr = "https://www.google.com"
        vc.screenTitle = "Privacy Policy"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedTerms() {
        let vc = WebViewController.instantiate(appStoryboard: .home)
        vc.urlStr = "https://www.google.com"
        vc.screenTitle = "Terms and Conditions"

        self.navigationController?.pushViewController(vc, animated: true)
    }

}
