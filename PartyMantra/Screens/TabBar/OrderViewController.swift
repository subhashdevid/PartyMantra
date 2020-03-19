//
//  OrderViewController.swift
//  PartyMantra
//
//  Created by Mayank Purwar on 15/02/20.
//  Copyright © 2020 Mayank Purwar. All rights reserved.
//

import UIKit

class OrderViewController: BaseViewController {
@IBOutlet weak var collectionView: UICollectionView!
    var dataArr = [orderModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                    self?.dataArr = orderList
                    self?.collectionView.reloadData()
                }
                
            case .failure: break
            }
        }
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
        
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectionCell: UICollectionViewCell?
        
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as? OrderCell
        let notification = dataArr[indexPath.row]
        cell?.configureCell(data: notification)

        

      //  let url = URL(string: brand.image ?? "" )
      //  cell?.imgView.kf.setImage(with: url, placeholder: nil)
        
        collectionCell = cell
        
        return collectionCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailViewController.instantiate(appStoryboard: .home) as DetailViewController
//        vc.product = dataArr[indexPath.row]
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
    
    func configureCell(data: orderModel) {
        lblName.text = data.title
        lblPrice.text = "₹\(data.total ?? 0)"
        lblDate.text = data.updated_at
        lblPaid.text = data.payment_status
        GlobalFunction.shared.downloadImage(imageView: imgView, urlStr: data.image ?? "")
    }
}
