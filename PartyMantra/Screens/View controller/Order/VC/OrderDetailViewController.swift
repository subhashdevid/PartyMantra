//
//  OrderDetailViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 31/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    var orderId : String?
    var orderModal : OrderDetaillistModel?
    var checkoutModel : OrderCheckoutModel?
    var refid: String?
    
    @IBOutlet weak var orderCheckoutTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        orderCheckoutTableview.separatorStyle = .none
        self.view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchOrderDetails()
    }
    
    func createUrl() -> String {
       
        let accessUserToken =  UserDefaults.standard.string(forKey: "AccessToken")
               let param: [String: Any] = [
                   "token":accessUserToken ?? ""
               ]
      
        var url = ""
        if let refid = refid {
            url = Server.shared.orderDetailUrl + "/\(refid)"
        }
        return url
    }
    
    func fetchOrderDetails() {
        Loader.showHud()
        
        let param: [String: Any] = [
            
            :]
        NetworkManager.getOrderDetails(url: createUrl(),parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                if let checkout = response.data {
                    self?.checkoutModel = checkout
                    print(self?.checkoutModel!)

                    self?.orderCheckoutTableview.reloadData()
                }
                
            case .failure: break
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 5
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            var cell: EventDetailInfoTableViewCell! = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "EventDetailInfoTableViewCell") as? EventDetailInfoTableViewCell
            if cell == nil {
                orderCheckoutTableview.register(UINib(nibName: "EventDetailInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "EventDetailInfoTableViewCell")
                cell = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "EventDetailInfoTableViewCell") as? EventDetailInfoTableViewCell
            }
            cell.configureCheckoutCell(checkOutModal: self.checkoutModel,orderModal:orderModal)
            return cell
            
        }else if indexPath.row == 1{
            var cell: detailPackageTableViewCell! = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "detailPackageTableViewCell") as? detailPackageTableViewCell
            if cell == nil {
                orderCheckoutTableview.register(UINib(nibName: "detailPackageTableViewCell", bundle: nil), forCellReuseIdentifier: "detailPackageTableViewCell")
                cell = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "detailPackageTableViewCell") as? detailPackageTableViewCell
            }
            cell.configureCheckoutListTableView(dataModal : self.checkoutModel)
            return cell
            
        }else if indexPath.row == 2{
            var cell: AllTaxesTableViewCell! = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "AllTaxesTableViewCell") as? AllTaxesTableViewCell
            if cell == nil {
                orderCheckoutTableview.register(UINib(nibName: "AllTaxesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllTaxesTableViewCell")
                cell = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "AllTaxesTableViewCell") as? AllTaxesTableViewCell
            }
            
            cell.configureTaxCell(modal: self.checkoutModel)
            return cell
            
        }else if indexPath.row == 3{
            var cell: SpecialEventDetailsTableViewCell! = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "SpecialEventDetailsTableViewCell") as? SpecialEventDetailsTableViewCell
            if cell == nil {
                orderCheckoutTableview.register(UINib(nibName: "SpecialEventDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "SpecialEventDetailsTableViewCell")
                cell = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "SpecialEventDetailsTableViewCell") as? SpecialEventDetailsTableViewCell
            }
            
            cell.configureSpecialDetail(modal: self.checkoutModel)
            return cell
            
        }else{
            var cell: QRCodeTableViewCell! = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "QRCodeTableViewCell") as? QRCodeTableViewCell
            if cell == nil {
                orderCheckoutTableview.register(UINib(nibName: "QRCodeTableViewCell", bundle: nil), forCellReuseIdentifier: "QRCodeTableViewCell")
                cell = orderCheckoutTableview.dequeueReusableCell(withIdentifier: "QRCodeTableViewCell") as? QRCodeTableViewCell
            }
            
           
            
            let qrCode = self.checkoutModel?.qrcode ?? ""
            let url : URL = NSURL(string: qrCode)! as URL
            
            
            // this downloads the image asynchronously if it's not cached yet
            cell.qrCodeImage.kf.setImage(with: url, placeholder: UIImage(named: "applogo_1024"))
            
            
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
             
            let numberOfCell = self.checkoutModel?.packages?.count ?? 0
           return  (CGFloat(37*numberOfCell+20))
        }else{
            return UITableView.automaticDimension
        }
    }
   
    
}



