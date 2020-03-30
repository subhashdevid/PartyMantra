//
//  LocationSelectViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 29/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class LocationSelectViewController: BaseViewController {

    var mobile : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true

        self.title = "Location"
        self.redirectToAddressScreen()
    }
    
    func redirectToAddressScreen()  {
           
            let vc = AddressSearchViewController.instantiate(appStoryboard: .miscellaneous) as AddressSearchViewController
        
        vc.mobileString = self.mobile
                self.navigationController?.pushViewController(vc, animated: true)
       }

}
