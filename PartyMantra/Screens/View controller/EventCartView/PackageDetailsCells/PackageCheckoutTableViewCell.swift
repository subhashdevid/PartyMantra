//
//  PackageCheckoutTableViewCell.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 29/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class PackageCheckoutTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var cellTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        cellTableView.isScrollEnabled = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: selectedPackageTableViewCell! = cellTableView.dequeueReusableCell(withIdentifier: "selectedPackageTableViewCell") as? selectedPackageTableViewCell
        if cell == nil {
            cellTableView.register(UINib(nibName: "selectedPackageTableViewCell", bundle: nil), forCellReuseIdentifier: "selectedPackageTableViewCell")
            cell = cellTableView.dequeueReusableCell(withIdentifier: "selectedPackageTableViewCell") as? selectedPackageTableViewCell
        }
                    
          return cell
    }
    
}
