//
//  CancelOrderViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 01/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit


class CancelOrderViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var topBreadcrum: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var crossbtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.crossbtn.addTarget(self, action: #selector(didTapCrossBtn), for: .touchUpInside)
    }
    
    @objc func didTapCrossBtn() {
        dismiss(animated: true, completion: nil)
    }
    
}
