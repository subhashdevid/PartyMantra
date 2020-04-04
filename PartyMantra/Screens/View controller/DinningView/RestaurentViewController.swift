//
//  RestaurentViewController.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class RestaurentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    @IBOutlet weak var restaurentTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 5
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.row == 0 {
            var cell: GallaryActionTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryActionTableViewCell") as? GallaryActionTableViewCell
            if cell == nil {
                restaurentTblView.register(UINib(nibName: "GallaryActionTableViewCell", bundle: nil), forCellReuseIdentifier: "GallaryActionTableViewCell")
                cell = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryActionTableViewCell") as? GallaryActionTableViewCell
            }
            
            return cell
        }else if  indexPath.row == 1 {
            var cell: GallaryInfoTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryInfoTableViewCell") as? GallaryInfoTableViewCell
                       if cell == nil {
                           restaurentTblView.register(UINib(nibName: "GallaryInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "GallaryInfoTableViewCell")
                           cell = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryInfoTableViewCell") as? GallaryInfoTableViewCell
                       }
                       
                       return cell
            
            
            
        }else{
            var cell: GallaryActionTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryActionTableViewCell") as? GallaryActionTableViewCell
            if cell == nil {
                restaurentTblView.register(UINib(nibName: "GallaryActionTableViewCell", bundle: nil), forCellReuseIdentifier: "GallaryActionTableViewCell")
                cell = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryActionTableViewCell") as? GallaryActionTableViewCell
            }
            
            return cell
        }
    }

}
