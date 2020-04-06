//
//  SuccessViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 06/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var successLbl: UILabel!
    @IBOutlet weak var successBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true

        successBtn.addTarget(self, action: #selector(redirectToHome), for: .touchUpInside)
    }
    
    
    @objc func redirectToHome() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showHomeScreen()
    }

}
