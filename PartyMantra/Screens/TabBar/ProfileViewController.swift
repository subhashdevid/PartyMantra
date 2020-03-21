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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    @IBAction func clickedUpdateProfile() {
        
    }
    
    @IBAction func clickedLogout() {
        
    }
    
    @IBAction func clickedAboutUs() {
        let vc = WebViewController.instantiate(appStoryboard: .home)
        vc.urlStr = "www.google.com"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedPrivacy() {
        let vc = WebViewController.instantiate(appStoryboard: .home)
        vc.urlStr = "www.google.com"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedTerms() {
        let vc = WebViewController.instantiate(appStoryboard: .home)
        vc.urlStr = "www.google.com"
        self.navigationController?.pushViewController(vc, animated: true)
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
