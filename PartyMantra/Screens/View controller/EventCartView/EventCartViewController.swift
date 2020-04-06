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
    var isWallet = "0"
    var dataDict : Dictionary<String,AnyObject> = [:]
    @IBOutlet weak var eventCarttableView: UITableView!
    
    var pay = PaymentViewController()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
      
      override func viewWillAppear(_ animated: Bool) {
           NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationForCart(notification:)), name: Notification.Name("CartNotificationIdentifier"), object: nil)
       }
       
  @objc func methodOfReceivedNotificationForCart(notification: Notification) {

    let vc = SuccessViewController.instantiate(appStoryboard: .miscellaneous) as SuccessViewController
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 6
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SubmitBtnTableViewCell! = eventCarttableView.dequeueReusableCell(withIdentifier: "SubmitBtnTableViewCell") as? SubmitBtnTableViewCell
        
        if indexPath.row == 0{
            var cell: EventDetailInfoTableViewCell! = eventCarttableView.dequeueReusableCell(withIdentifier: "EventDetailInfoTableViewCell") as? EventDetailInfoTableViewCell
            if cell == nil {
                eventCarttableView.register(UINib(nibName: "EventDetailInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "EventDetailInfoTableViewCell")
                cell = eventCarttableView.dequeueReusableCell(withIdentifier: "EventDetailInfoTableViewCell") as? EventDetailInfoTableViewCell
            }
            cell.backgroundColor = .groupTableViewBackground
            cell.configureEventDetailCheckoutCell(data: dataDict)
            
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
           cell.submitCellBtn.addTarget(self, action: #selector(didTapSubmitButton(sender:)), for: .touchUpInside)
         return cell
        }
       
  return cell!
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
            isWallet = "1"
            
            if #available(iOS 13.0, *) {
                cell.checkBoxImage.image = UIImage(systemName:"checkmark.square")
            } else {
                 cell.checkBoxImage.image = UIImage.init(named: "check")
            }
        }else{
            isWallet = "0"

            if #available(iOS 13.0, *) {
                cell.checkBoxImage.image = UIImage(systemName:"square")
            } else {
                 cell.checkBoxImage.image = UIImage.init(named: "uncheck")
            }
        }
       
    }

        
      @objc func didTapSubmitButton(sender:UIButton){
        self.payNowOption(walletEnable: isWallet)
    }
    
    func payNowOption(walletEnable : String)  {
               
        let param: [String: String] = [
            "usingwallet": walletEnable
        ]

        Loader.showHud()
        Multipart().formDataAPICall(mainView: self.view, urlString: Server.shared.paynowUrl, parameter: param , handler: { (response, isSuccess) in

            if isSuccess{
                Loader.dismissHud()
               let response = response as! Dictionary<String,Any>
                
                print(response)

                let paymentdone = response["paymentdone"] as? String
                let responseDict = response["data"] as! Dictionary<String,Any>
                print(responseDict)

                let payStr = (responseDict["total"] ?? "0")
                let orderIDStr = (responseDict["orderid"] ?? "0")

                if paymentdone == "yes" {
                    let vc = SuccessViewController.instantiate(appStoryboard: .miscellaneous) as SuccessViewController
                    self.navigationController?.pushViewController(vc, animated: true)

                }else{
                    self.pay.addMoneyToPay(amount: "\(payStr)", payOrderid: "\(orderIDStr)", screen: "cart")

                }
                
            }
        })
    }
    
    
    
    
    /*
     
     "status": "success",
        "message": "success",
        "paymentdone": "no",
        "data": {
            "orderid": "order_Eb9NA7OExAtUwm",
            "total": 100000,
            "email": "dgg@h.com",
            "mobile": "6666666666",
            "description": "Imperfecto Daily Event",
            "address": "",
            "name": "dgg",
            "currency": "INR",
            "merchantid": "Dvd9xhIQc0l4L3"
        }
     **/
    
}
