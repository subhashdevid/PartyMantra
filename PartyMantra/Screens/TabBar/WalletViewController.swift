//
//  WalletViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class WalletViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArr = [WalletHistory]()
    var balance = WalletBalance(balance: 0)
    
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var addMoneyButton: UIButton!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addMoneyButton.addTarget(self, action: #selector(didSelectAddMoney), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationItem.title = "Wallet History"
        
        getWalletHistory()
        getWalletBalance()
    }
    
    
    func getWalletHistory() {
        let param: [String: Any] = [
            
            :]
        Loader.showHud()
        NetworkManager.getWalletHistory(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                if let notification = response.data {
                    self?.dataArr = notification.history!
                    self?.collectionView.reloadData()
                }
                
            case .failure: break
            }
        }
    }
    
    func getWalletBalance() {
        let param: [String: Any] = [
            
            :]
        Loader.showHud()
        NetworkManager.getWalletBalace(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                if let notification = response.data {
                    self?.balance = notification
                    
                    let amount = "\(self?.balance.balance ?? 0)"
                    self?.lblBalance.text =  "\u{20B9}" + amount
                }
                
            case .failure: break
            }
        }
    }
    
    //MARK:didSelectAddMoney
    
    @objc func didSelectAddMoney() {
        
        let walletVc = AddBalanceViewController.instantiate(appStoryboard: .home) as AddBalanceViewController
         self.navigationController?.pushViewController(walletVc, animated: true)
        
    }
  

}

extension WalletViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return size(indexPath: indexPath)
     }

     private func size(indexPath: IndexPath) -> CGSize {
         // load cell from Xib
         let cell = collectionView
         .dequeueReusableCell(withReuseIdentifier: "WalletCell", for: indexPath) as? WalletCell
        

         // configure cell with data in it
         let notification = dataArr[indexPath.row]
        cell?.configureCell(data: notification)

         cell?.setNeedsLayout()
         cell?.layoutIfNeeded()

         // width that you want
         let width = collectionView.frame.width
         let height: CGFloat = 0

         let targetSize = CGSize(width: width-20, height: height)

         // get size with width that you want and automatic height
        let size = (cell?.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .fittingSizeLevel))!
         // if you want height and width both to be dynamic use below
         // let size = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)

         return size
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
            .dequeueReusableCell(withReuseIdentifier: "WalletCell", for: indexPath) as? WalletCell
        let notification = dataArr[indexPath.row]
        cell?.configureCell(data: notification)
        collectionCell = cell
        
        return collectionCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailViewController.instantiate(appStoryboard: .home) as DetailViewController
//        vc.product = dataArr[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
    }

}


class WalletCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    func configureCell(data: WalletHistory) {
        bgView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .groupTableViewBackground
        lblTitle.text = data.description
        lblPrice.text = "\u{20B9} \(data.amount ?? 0)"
        lblDate.text = data.date
        
        if data.type == "Debit" {
            imgView.image = UIImage(named: "rupee_red")

        }else{
            imgView.image = UIImage(named: "rupee_green")

        }
    }
}
