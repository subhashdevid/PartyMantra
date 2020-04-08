//
//  GalleryWebViewController.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 08/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class GalleryWebViewController: BaseViewController {

    @IBOutlet weak var titleLbl: UILabel!
       @IBOutlet weak var topBreadcrum: UIView!
       @IBOutlet weak var crossbtn: UIButton!
       @IBOutlet weak var webView: UIWebView!

    var docString : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: self.docString ?? "")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
        
    }
    
}
