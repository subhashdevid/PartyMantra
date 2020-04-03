//
//  OrderViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import EzPopup


class OrderViewController: BaseViewController {
@IBOutlet weak var collectionView: UICollectionView!
    var ordersData : [OrderDetaillistModel] = []

    var cancel_dict : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Order"
        getOrderList()

    }
    
    func getOrderList() {
        let param: [String: Any] = [
            
            :]
        Loader.showHud()
        NetworkManager.getOrderList(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                if let orderList = response.data {
                   self?.ordersData.removeAll()
                    
                    self?.cancel_dict = orderList.cancel_reasons
                    
                    for dict in orderList.ordersdetail {
                        print(dict)
                        let model = OrderDetaillistModel.init(response: dict as? [String:Any] ?? [:])
                        self?.ordersData.append(model)
                    }
                    
                    self?.collectionView.reloadData()
                }
                
            case .failure: break
            }
        }
    }
    
    
    @objc func didtapCancelOrder(sender : UIButton?) {
        
        let order = (self.ordersData[sender?.tag ?? 0] as? OrderDetaillistModel)!
        let vc = CancelOrderViewController.instantiate(appStoryboard: .miscellaneous) as CancelOrderViewController
        vc.cancel_dict = self.cancel_dict
        vc.refid = order.refid
        let popupVC = PopupViewController(contentController: vc, popupWidth: 380, popupHeight: 380)
        popupVC.cornerRadius = 20
        present(popupVC, animated: true)
    }
}

extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: self.view.width, height: 150)
     }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ordersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectionCell: UICollectionViewCell?
        
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as? OrderCell
        let orderDataDetails = (self.ordersData[indexPath.row] as? OrderDetaillistModel)!
        cell?.configureCell(data: orderDataDetails)
        
        cell?.cancelOrderbtn.tag = indexPath.row
        cell?.cancelOrderbtn.addTarget(self, action: #selector(didtapCancelOrder(sender:)), for: .allTouchEvents)
        collectionCell = cell
        cell?.viewMoreOrderbtn.tag = indexPath.row
        cell?.viewMoreOrderbtn.addTarget(self, action: #selector(didtapToViewOrder), for: .touchUpInside)
        
        return collectionCell ?? UICollectionViewCell()
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = OrderDetailViewController.instantiate(appStoryboard: .miscellaneous) as OrderDetailViewController
//        vc.refid = ordersData[indexPath.row].refid
//        vc.orderModal = ordersData[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    
    @objc func didtapToViewOrder(sender : UIButton?) {
        
        let vc = OrderDetailViewController.instantiate(appStoryboard: .miscellaneous) as OrderDetailViewController
        vc.refid = ordersData[sender?.tag ?? 0].refid
        vc.orderModal = ordersData[sender?.tag ?? 0]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


class OrderCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPaid: UILabel!
    
    @IBOutlet weak var cancelOrderbtn: UIButton!
    @IBOutlet weak var viewMoreOrderbtn: UIButton!
    @IBOutlet weak var reviewOrderbtn: UIButton!

    func configureCell(data: OrderDetaillistModel) {
       lblName.text = data.title
        lblPrice.text = "₹\(data.total ?? 0)"
        lblDate.text = data.updated_at
        lblPaid.text = data.payment_status
        GlobalFunction.shared.downloadImage(imageView: imgView, urlStr: data.image ?? "")
    }
}
