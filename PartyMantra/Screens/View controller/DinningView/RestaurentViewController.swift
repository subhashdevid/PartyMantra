//
//  RestaurentViewController.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class RestaurentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var restaurentTblView: UITableView!
    var restModal : RestaurantInfoModel?
    
    
    var eventID : Int = 0
    var type: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchRestaurantMenuListDetail()
    }
    
    func createUrl() -> String {
        let url = Server.shared.restaurentUrl + "/\(eventID)"
        print(url)
        return url
    }
    
    
    func fetchRestaurantMenuListDetail() {
        
        let param: [String: Any] = [:]
        Loader.showHud()
        NetworkManager.getRestrauntDetailListing(url: createUrl(),parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                if let dinning = response.data {
                    self?.restModal = RestaurantInfoModel(response: dinning.restaurant)
                    self?.restaurentTblView.reloadData()
                }
            case .failure: break
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.row == 0 {
            var cell: GallaryActionTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryActionTableViewCell") as? GallaryActionTableViewCell
            if cell == nil {
                restaurentTblView.register(UINib(nibName: "GallaryActionTableViewCell", bundle: nil), forCellReuseIdentifier: "GallaryActionTableViewCell")
                cell = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryActionTableViewCell") as? GallaryActionTableViewCell
            }
            
            let url = URL(string: self.restModal?.header_image ?? "")
            cell?.gallaryImageView.contentMode = .scaleAspectFill
            cell?.gallaryImageView.kf.setImage(with: url, placeholder: nil)
            
            
            return cell
        }else if  indexPath.row == 1 {
            var cell: GallaryInfoTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryInfoTableViewCell") as? GallaryInfoTableViewCell
            if cell == nil {
                restaurentTblView.register(UINib(nibName: "GallaryInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "GallaryInfoTableViewCell")
                cell = restaurentTblView.dequeueReusableCell(withIdentifier: "GallaryInfoTableViewCell") as? GallaryInfoTableViewCell
            }
            
            cell.cellTitleLabel.text = self.restModal?.name ?? ""
            cell.cellSubTitleLabel.text = self.restModal?.short_address ?? ""
            cell.cellDetailLabel.text = self.restModal?.description ?? ""
            
            cell.ratingView.isUserInteractionEnabled = false
            cell.ratingView.settings.fillMode = .half
            
            let rate = self.restModal?.avgreviews[0]
                //self.restModal?.avgreviews[0] as? RestaurantAvgReviewsModel
            cell.ratingView.rating = Double(rate?.rating ?? "0") ?? 0.0
            
            return cell
            
            
            
        }else if  indexPath.row == 2 {
            var cell: RestaurentOptionTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "RestaurentOptionTableViewCell") as? RestaurentOptionTableViewCell
            if cell == nil {
                restaurentTblView.register(UINib(nibName: "RestaurentOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "RestaurentOptionTableViewCell")
                cell = restaurentTblView.dequeueReusableCell(withIdentifier: "RestaurentOptionTableViewCell") as? RestaurentOptionTableViewCell
            }
            
            
            
            
            return cell
            
        }else if  indexPath.row == 3 {
            var cell: PromoRestaurentTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "PromoRestaurentTableViewCell") as? PromoRestaurentTableViewCell
            if cell == nil {
                restaurentTblView.register(UINib(nibName: "PromoRestaurentTableViewCell", bundle: nil), forCellReuseIdentifier: "PromoRestaurentTableViewCell")
                cell = restaurentTblView.dequeueReusableCell(withIdentifier: "PromoRestaurentTableViewCell") as? PromoRestaurentTableViewCell
            }
            
            cell.cashBackPercentLbl.text = "20% CASHBACK"
            cell.promoDetailLbl.text = "Use promo cash here to save up to on your bill.Also get cash back with Discount pay"
            
            
            return cell
        }else if  indexPath.row == 4 {
            var cell: RestBannerTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "RestBannerTableViewCell") as? RestBannerTableViewCell
            if cell == nil {
                restaurentTblView.register(UINib(nibName: "RestBannerTableViewCell", bundle: nil), forCellReuseIdentifier: "RestBannerTableViewCell")
                cell = restaurentTblView.dequeueReusableCell(withIdentifier: "RestBannerTableViewCell") as? RestBannerTableViewCell
            }
            
            cell.configureCell(model: restModal)
            return cell
            
        }else{
            var cell:  RestMenuListTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "RestMenuListTableViewCell") as?  RestMenuListTableViewCell
            if cell == nil {
                restaurentTblView.register(UINib(nibName: "RestMenuListTableViewCell", bundle: nil), forCellReuseIdentifier: "RestMenuListTableViewCell")
                cell = restaurentTblView.dequeueReusableCell(withIdentifier: "RestMenuListTableViewCell") as?  RestMenuListTableViewCell
            }
            
            cell.configureMenuDetails(dataModal: restModal)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5{
            return 85*5+10
        }else{
            return UITableView.automaticDimension
        }
    }
}
