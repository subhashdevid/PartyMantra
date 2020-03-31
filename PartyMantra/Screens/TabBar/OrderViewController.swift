//
//  OrderViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class OrderViewController: BaseViewController {
@IBOutlet weak var collectionView: UICollectionView!
    var dataArr = [orderModel]()
    var ordersData : [OrderDetaillistModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getOrderList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Order"
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
   
        collectionCell = cell
        
        return collectionCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailViewController.instantiate(appStoryboard: .home) as DetailViewController
//        vc.product = dataArr[indexPath.row]
        
        // refid
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


class OrderCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPaid: UILabel!
    
    func configureCell(data: OrderDetaillistModel) {
       lblName.text = data.title
        lblPrice.text = "₹\(data.total ?? 0)"
        lblDate.text = data.updated_at
        lblPaid.text = data.payment_status
        GlobalFunction.shared.downloadImage(imageView: imgView, urlStr: data.image ?? "")
    
    }
}
