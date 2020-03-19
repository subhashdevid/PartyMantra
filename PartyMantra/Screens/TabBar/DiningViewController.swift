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
        
        // Do any additional setup after loading the view.
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
                    print(self?.dataArr?.collections)
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

extension DiningViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.width, height: 150)
        } else if indexPath.section == 1{
            return CGSize(width: self.view.width, height: 150)
        } else if indexPath.section == 2 {
            
            let data = dataArr?.others?[indexPath.row]
            let count1: Int = data?.restaurant?.count ?? 0
            let count2: Int = data?.banners?.count ?? 0
            
            var rowCount = count1/3
            if count1 % 3 != 0 {
                rowCount = rowCount+1
            }
            let rowCount1 = count2 > 0 ? 1: 0
            
            
            return CGSize(width: self.view.width, height: CGFloat(rowCount*100) + CGFloat(rowCount1*150)+30.0)
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
        return CGSize(width: 60.0, height: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectionCell: UICollectionViewCell?
        if indexPath.section == 0 {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "\(ImageBannerCell.self)", for: indexPath) as? ImageBannerCell
            cell?.configureCell(imgData: dataArr?.banners ?? [])
            collectionCell = cell
        } else if indexPath.section == 1{
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "\(DiningCollectionCell.self)", for: indexPath) as? DiningCollectionCell
            cell?.configureCell(imgData: dataArr?.collections ?? [])
            cell?.viewButton.addTarget(self, action: #selector(viewCollection), for: .touchUpInside)
            collectionCell = cell
        } else if indexPath.section == 2 {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "\(DiningOtherCell.self)", for: indexPath) as? DiningOtherCell
            cell?.configureCell(homeOthers: dataArr?.others?[indexPath.row])
            cell?.viewButton.tag = indexPath.row
            cell?.viewButton.addTarget(self, action: #selector(viewDining(sender:)), for: .touchUpInside)
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
    
    @objc func viewDining(sender: UIButton) {
        let vc = CollectionViewController.instantiate(appStoryboard: .home) as CollectionViewController
        vc.type = self.type
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class DiningOtherCell1: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    var restaurantData: restaurantModel?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    func configureCell(data:restaurantModel?) {
        restaurantData = data
        lblName.text = restaurantData?.name
        lblDesc.text = restaurantData?.description
        let url = URL(string: restaurantData?.small_image ?? "")
        imgView.contentMode = .scaleAspectFill
        imgView.kf.setImage(with: url, placeholder: nil)
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
            return CGSize(width: Constants.windowWidth/3, height: 130)
        } else if indexPath.section == 1 {
            return CGSize(width: Constants.windowWidth, height: 130)
        }
        return CGSize(width: 100, height: 130)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionCell: UICollectionViewCell?
        if indexPath.section == 0 {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "\(DiningOtherCell1.self)", for: indexPath) as? DiningOtherCell1
            cell?.configureCell(data: self.homeOthers?.restaurant?[indexPath.row])
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









class DiningCollectionCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewButton: UIButton!
    var imageData = [HomeCollection]()
    
    func configureCell(imgData:[HomeCollection]) {
        imageData = imgData
        collectionView.reloadData()
    }
}



extension DiningCollectionCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 130)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageCollectionViewCell.self)", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        
        let imgBanner = self.imageData[indexPath.row]
        let url = URL(string: imgBanner.small_image ?? "")
        
        cell.cellImage.kf.setImage(with: url, placeholder: nil)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}
//
//
//class ImageBannerCell: UICollectionViewCell {
//    @IBOutlet weak var collectionView: AutoScrollingCollectionView!
//    var imageData = [HomeBanners]()
//    
//    func configureCell(imgData:[HomeBanners]) {
//        imageData = imgData
//        collectionView.reloadData()
//        collectionView.startScrolling()
//    }
//}
//
//
//extension ImageBannerCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.imageData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: Constants.windowWidth, height: 230)
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageCollectionViewCell.self)", for: indexPath) as? ImageCollectionViewCell else {
//            return UICollectionViewCell()
//            
//        }
//        
//        let imgBanner = self.imageData[indexPath.row]
//        let url = URL(string: imgBanner.image ?? "")
//        
//        cell.cellImage.kf.setImage(with: url, placeholder: nil)
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//    }
//    
//    
//}
//
//
//class ImageCollectionViewCell: UICollectionViewCell {
//    
//    @IBOutlet weak var cellImage: UIImageView!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.cellImage.contentMode = .scaleAspectFill
//    }
//    
//}
