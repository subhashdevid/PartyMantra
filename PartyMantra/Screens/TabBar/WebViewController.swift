//
//  WebViewController.swift
//  PartyMantra
//
//  Created by Mayank Purwar on 14/03/20.
//  Copyright © 2020 Mayank Purwar. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {

    var urlStr: String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let myURL = URL(string:urlStr ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        // Do any additional setup after loading the view.
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
