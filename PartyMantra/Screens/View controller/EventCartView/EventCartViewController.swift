//
//  EventCartViewController.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 29/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class EventCartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    var isCheckBoxSelected : Bool = false
    var dataDict : Dictionary<String,AnyObject> = [:]
    @IBOutlet weak var eventCarttableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(dataDict)
        
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 6
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: SubmitBtnTableViewCell! = eventCarttableView.dequeueReusableCell(withIdentifier: "SubmitBtnTableViewCell") as? SubmitBtnTableViewCell
        
        if indexPath.row == 0{
            var cell: EventDetailInfoTableViewCell! = eventCarttableView.dequeueReusableCell(withIdentifier: "EventDetailInfoTableViewCell") as? EventDetailInfoTableViewCell
            if cell == nil {
                eventCarttableView.register(UINib(nibName: "EventDetailInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "EventDetailInfoTableViewCell")
                cell = eventCarttableView.dequeueReusableCell(withIdentifier: "EventDetailInfoTableViewCell") as? EventDetailInfoTableViewCell
            }
            cell.backgroundColor = .groupTableViewBackground
            cell.configureEventDetailCheckoutCell(data: dataDict)
            //  cell.submitCellBtn.addTarget(self, action: #selector(didTapToOpenEventCart), for: .touchUpInside)
            
            return cell
        }else if indexPath.row == 1{
            var cell: PackageCheckoutTableViewCell! = eventCarttableView.dequeueReusableCell(withIdentifier: "PackageCheckoutTableViewCell") as? PackageCheckoutTableViewCell
             if cell == nil {
                 eventCarttableView.register(UINib(nibName: "PackageCheckoutTableViewCell", bundle: nil), forCellReuseIdentifier: "PackageCheckoutTableViewCell")
                 cell = eventCarttableView.dequeueReusableCell(withIdentifier: "PackageCheckoutTableViewCell") as? PackageCheckoutTableViewCell
             }
              cell.backgroundColor = .groupTableViewBackground
            cell.getPackageDetails(data: dataDict)
            //  cell.submitCellBtn.addTarget(self, action: #selector(didTapToOpenEventCart), for: .touchUpInside)
            return cell
        }else if indexPath.row == 2{
            var cell: AllTaxesTableViewCell! = eventCarttableView.dequeueReusableCell(withIdentifier: "AllTaxesTableViewCell") as? AllTaxesTableViewCell
             if cell == nil {
                 eventCarttableView.register(UINib(nibName: "AllTaxesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllTaxesTableViewCell")
                 cell = eventCarttableView.dequeueReusableCell(withIdentifier: "AllTaxesTableViewCell") as? AllTaxesTableViewCell
             }
              cell.backgroundColor = .groupTableViewBackground
            cell.configureEventTaxCell(dataDict: dataDict)
            //  cell.submitCellBtn.addTarget(self, action: #selector(didTapToOpenEventCart), for: .touchUpInside)
            return cell
        }else if indexPath.row == 3{
        var cell: SpecialEventDetailsTableViewCell! = eventCarttableView.dequeueReusableCell(withIdentifier: "SpecialEventDetailsTableViewCell") as? SpecialEventDetailsTableViewCell
         if cell == nil {
             eventCarttableView.register(UINib(nibName: "SpecialEventDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "SpecialEventDetailsTableViewCell")
             cell = eventCarttableView.dequeueReusableCell(withIdentifier: "SpecialEventDetailsTableViewCell") as? SpecialEventDetailsTableViewCell
         }
            
          cell.backgroundColor = .groupTableViewBackground
            cell.configureEventSpecialDetail(data:dataDict)
        //  cell.submitCellBtn.addTarget(self, action: #selector(didTapToOpenEventCart), for: .touchUpInside)
        return cell
        }else if indexPath.row == 4{
        var cell: UseWalletTableViewCell! = eventCarttableView.dequeueReusableCell(withIdentifier: "UseWalletTableViewCell") as? UseWalletTableViewCell
         if cell == nil {
             eventCarttableView.register(UINib(nibName: "UseWalletTableViewCell", bundle: nil), forCellReuseIdentifier: "UseWalletTableViewCell")
             cell = eventCarttableView.dequeueReusableCell(withIdentifier: "UseWalletTableViewCell") as? UseWalletTableViewCell
         }
          cell.backgroundColor = .groupTableViewBackground
            cell.configureWalletOption(data: dataDict)
          cell.checkBoxBtn.addTarget(self, action: #selector(didTapCheckBoxOption(sender: )), for: .touchUpInside)
        return cell
        }else{
         var cell: SubmitBtnTableViewCell! = eventCarttableView.dequeueReusableCell(withIdentifier: "SubmitBtnTableViewCell") as? SubmitBtnTableViewCell
          if cell == nil {
              eventCarttableView.register(UINib(nibName: "SubmitBtnTableViewCell", bundle: nil), forCellReuseIdentifier: "SubmitBtnTableViewCell")
              cell = eventCarttableView.dequeueReusableCell(withIdentifier: "SubmitBtnTableViewCell") as? SubmitBtnTableViewCell
          }
           cell.backgroundColor = .groupTableViewBackground
         //  cell.submitCellBtn.addTarget(self, action: #selector(didTapToOpenEventCart), for: .touchUpInside)
         return cell
        }
       
  return cell
}


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
        let dict = dataDict["data"] as? Dictionary<String,AnyObject> ?? [:]
        let dictArr = dict["packages"] as? Array<Dictionary<String,AnyObject>> ?? []
            let numberOfCell = dictArr.count
         let height = (numberOfCell-1)
            return  (CGFloat(140+(30*height)))
        }
        return UITableView.automaticDimension
    }

    
    @objc func didTapCheckBoxOption(sender:UIButton){
        self.isCheckBoxSelected = !self.isCheckBoxSelected
        guard let cell = sender.superview?.superview?.superview as? UseWalletTableViewCell else {
            return
        }
        
        if self.isCheckBoxSelected{
            if #available(iOS 13.0, *) {
                cell.checkBoxImage.image = UIImage(systemName:"checkmark.square")
            } else {
                 cell.checkBoxImage.image = UIImage.init(named: "check")
                // Fallback on earlier versions
            }//UIImage.init(named: "checkmark.square")
        }else{
            if #available(iOS 13.0, *) {
                cell.checkBoxImage.image = UIImage(systemName:"square")
            } else {
                 cell.checkBoxImage.image = UIImage.init(named: "uncheck")
                // Fallback on earlier versions
            }
        }
       
    }

}
