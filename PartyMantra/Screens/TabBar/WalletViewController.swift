//
//  WalletViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class WalletViewController: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    
    var dataArr = [WalletHistory]()
    var balance = WalletBalance(balance: 0)
    
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var addMoneyButton: UIButton!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tblView.rowHeight = 44
        self.tblView.estimatedRowHeight = UITableView.automaticDimension
        
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
                    self?.tblView.reloadData()
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

extension WalletViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = self.tblView.dequeueReusableCell(withIdentifier: "WalletCell") as? WalletCell
        let walletObj = dataArr[indexPath.row]
        
        //cell?.bgView.backgroundColor = .clear
        //cell?.contentView.layer.cornerRadius = 10
        //cell?.contentView.layer.masksToBounds = true
        //cell?.contentView.backgroundColor = .groupTableViewBackground
        cell?.lblTitle.text = walletObj.description
        cell?.lblPrice.text = "\u{20B9} \(walletObj.amount ?? 0)"
        cell?.lblDate.text = walletObj.date
        
        if walletObj.type == "Debit" {
            cell?.imgView.image = UIImage(named: "rupee_red")
        }else{
            cell?.imgView.image = UIImage(named: "rupee_green")
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


class WalletCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!

}
