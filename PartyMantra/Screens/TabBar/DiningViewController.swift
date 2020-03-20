//
//  DiningViewController.swift
//  PartyMantra
//
//  Created by Mayank Purwar on 15/02/20.
//  Copyright © 2020 Mayank Purwar. All rights reserved.
//

import UIKit

class DiningViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var dataArr: HomeModel?
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListing()
    }
    
    func getListing() {
        var param: [String: Any] = [
            :]
        if type != "" {
            param["type"] = self.type
        }
        Loader.showHud()
        NetworkManager.getHomeListing(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                if let notification = response.data {
                    self?.dataArr = notification
                    self?.collectionView.reloadData()
                    print(self?.dataArr?.collections as Any)
                }
                
            case .failure: break
            }
        }
    }
}

extension DiningViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.width, height: 200)
        }
        else if indexPath.section == 1{
            return CGSize(width: self.view.width, height: 150)
        }
        else if indexPath.section == 2 {
            
            let data = dataArr?.others?[indexPath.row]
            let count1: Int = data?.restaurant?.count ?? 0
            let count2: Int = data?.banners?.count ?? 0
            
            var rowCount = count1/3
            
            if count1 % 3 != 0 {
                rowCount = rowCount + 1
            }
            let rowCount1 = count2 > 0 ? 1: 0
            return CGSize(width: self.view.width, height: CGFloat(rowCount * 140) + CGFloat(rowCount1 * 181) + 40.0)
            //3
        }
        return CGSize(width: self.view.width, height: 150)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return dataArr?.others?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            CGSize(width: collectionView.frame.width, height: 0)
        } else if section == 1{
            
        } else if section == 2 {
            
        }
        return CGSize(width: collectionView.frame.width, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            
        } else if section == 1{
            
        } else if section == 2 {
            
        }
        return CGSize(width: 0.0, height: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectionCell: UICollectionViewCell?
        
        if indexPath.section == 0 {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "\(ImageBannerCell.self)", for: indexPath) as? ImageBannerCell
            cell?.configureCell(imgData: dataArr?.banners ?? [])
            collectionCell = cell
        }
        else if indexPath.section == 1{
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "\(EventCollectionCell.self)", for: indexPath) as? EventCollectionCell
            cell?.configureCell(imgData: dataArr?.collections ?? [])
            cell?.viewButton.addTarget(self, action: #selector(viewCollection), for: .touchUpInside)
            collectionCell = cell
        }
        else if indexPath.section == 2 {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "\(DiningOtherCell.self)", for: indexPath) as? DiningOtherCell
            cell?.configureCell(homeOthers: dataArr?.others?[indexPath.row])
            
            cell?.viewButton.tag = indexPath.row
            cell?.viewButton.addTarget(self, action: #selector(viewEvent(sender:)), for: .touchUpInside)
            collectionCell = cell
        }
        return collectionCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc = DetailViewController.instantiate(appStoryboard: .home) as DetailViewController
        //        vc.product = dataArr[indexPath.row]
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func viewCollection() {
        let vc = CollectionViewController.instantiate(appStoryboard: .home) as CollectionViewController
        vc.type = self.type
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func viewEvent(sender: UIButton) {
        let vc = CollectionViewController.instantiate(appStoryboard: .home) as CollectionViewController
        vc.type = self.type
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


class DiningOtherCell1: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    var eventData: eventModel?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var rateImg: UIImageView!
    
    
    
    func configureCell(restaurantData:restaurantModel?) {
       
        lblName.text = restaurantData?.name
        lblDesc.text = restaurantData?.description
        let url = URL(string: restaurantData?.small_image ?? "")
        imgView.contentMode = .scaleAspectFill
        imgView.kf.setImage(with: url, placeholder: nil)
   

        if restaurantData?.avgreviews?.count ?? 0 > 0 {
            rateView.isHidden = false
            rateLbl.isHidden = false
            rateImg.isHidden = false
            rateImg.image = UIImage(named: "StarIcon")

            let rate = restaurantData?.avgreviews?[0]
            let value = Double(rate?.rating ?? "0.0")
            rateLbl.text = String(format:"%.1f", value ?? 0.0)

        }else{
            rateView.isHidden = true
            rateLbl.isHidden = true
            rateImg.isHidden = true
        }
   
    }
}


class DiningOtherCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var homeOthers: HomeOthers?

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    
    func configureCell(homeOthers:HomeOthers?) {
        lblName.text = homeOthers?.name
        lblDesc.text = homeOthers?.about
        viewButton.layer.cornerRadius = 10
        viewButton.layer.masksToBounds = true
        self.homeOthers = homeOthers
        collectionView.reloadData()
    }
}
extension DiningOtherCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return homeOthers?.restaurant?.count ?? 0
        } else if section == 1 {
            return (homeOthers?.banners?.count ?? 0) > 0 ? 1 : 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: Constants.windowWidth/3.3, height: 130)
        } else if indexPath.section == 1 {
            return CGSize(width: Constants.windowWidth, height: 180)
        }
        return CGSize(width: 100, height: 130)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionCell: UICollectionViewCell?
        if indexPath.section == 0 {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "\(DiningOtherCell1.self)", for: indexPath) as? DiningOtherCell1
                            
//            cell?.configureCell(data: self.homeOthers?.restaurant?[indexPath.row])
            
            cell?.configureCell(restaurantData: self.homeOthers?.restaurant?[indexPath.row])
            collectionCell = cell
        } else if indexPath.section == 1 {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "\(ImageBannerCell.self)", for: indexPath) as? ImageBannerCell
            cell?.configureCell(imgData: self.homeOthers?.banners ?? [])
            collectionCell = cell
        }
        
        
        

        return collectionCell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}


