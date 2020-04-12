//
//  RestaurentViewController.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 04/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import EzPopup


class RestaurentViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var restaurentTblView: UITableView!
    @IBOutlet weak var payNowBtn: UIButton!
    @IBOutlet weak var bookNowBtn: UIButton!

    var restModal : RestaurantInfoModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    var eventID : Int = 0
    var type: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurentTblView.tableFooterView = UIView()
        self.bookNowBtn.addTarget(self, action: #selector(didtapBookNowBtn(sender:)), for: .touchUpInside)
        self.payNowBtn.addTarget(self, action: #selector(didtapPayNowBtn(sender:)), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpTabBarAndNavigationTitle(tabBarHidden: true, navigationTitle:"Restaurant Details")
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
    
    
    
    @objc func didtapBookNowBtn(sender : UIButton?) {
        
        
               let vc = BookingViewController.instantiate(appStoryboard: .dinning) as BookingViewController
               vc.type = "restaurant"
        vc.restModal = self.restModal
        //self.navigationController?.pushViewController(vc, animated: true)
        let popupVC = PopupViewController(contentController: vc, popupWidth: (UIScreen.main.bounds.size.width)-20, popupHeight: (UIScreen.main.bounds.size.height) - 80)
        popupVC.cornerRadius = 20
        present(popupVC, animated: true)
        
        
       }
     @objc func didtapPayNowBtn(sender : UIButton?) {
   
           }
    
    @objc func didtapGalleryBtn(sender : UIButton?) {
            let vc = GalleryViewController.instantiate(appStoryboard: .miscellaneous) as GalleryViewController
            vc.eventId = "\(restModal?.id ?? 0)"
            vc.type = "restaurant"
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func didtapReviewOrder(sender : UIButton?) {
            let vc = ReviewsViewController.instantiate(appStoryboard: .miscellaneous) as ReviewsViewController
            
            vc.eventId = "\(restModal?.id ?? 0)"
            vc.type = "restaurant"
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func makeCall() {
        // agree
        self.callNumber(phoneNo: restModal?.contact_no ?? "")
    }
    
    
    func callNumber(phoneNo : String){
        appDelegate.callNumber(phoneNumber: phoneNo)
    }
    
    
    @objc  func redirectToMap(){
        self.openMapForRedirection(lat: restModal?.lat ?? "0.0", long: restModal?.lang ?? "0.0")
    }
    
    @objc  func didTapComboClicked(){


    }
    
    @objc  func didTapAboutOption( sender : UIButton){

               let vc = AboutViewController.instantiate(appStoryboard: .miscellaneous) as AboutViewController
//               vc.cancel_dict = self.cancel_dict
//               vc.refid = order.refid
               let popupVC = PopupViewController(contentController: vc, popupWidth: 380, popupHeight: 380)
               popupVC.cornerRadius = 20
               present(popupVC, animated: true)
    }
    
    
    //MARK:- Delegate
    
    
    
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
            cell?.gallaryImageView.kf.setImage(with: url, placeholder: UIImage(named: "applogo_1024"))
            cell.gallaryBtn.addTarget(self, action: #selector(didtapGalleryBtn(sender:)), for: .touchUpInside)
            
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
            cell.ratingView.rating = 0.0
           
            if self.restModal?.avgreviews.count ?? 0 > 0 {
                let rate = self.restModal?.avgreviews[0]
                cell.ratingView.rating = Double(rate?.rating ?? "0") ?? 0.0
            }
            
            cell.reviewBtn.addTarget(self, action: #selector(didtapReviewOrder(sender:)), for: .touchUpInside)
            
            return cell
            
            
            
        }else if  indexPath.row == 2 {
            var cell: RestaurentOptionTableViewCell! = restaurentTblView.dequeueReusableCell(withIdentifier: "RestaurentOptionTableViewCell") as? RestaurentOptionTableViewCell
            if cell == nil {
                restaurentTblView.register(UINib(nibName: "RestaurentOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "RestaurentOptionTableViewCell")
                cell = restaurentTblView.dequeueReusableCell(withIdentifier: "RestaurentOptionTableViewCell") as? RestaurentOptionTableViewCell
            }
            cell.aboutBtn.tag = indexPath.row
            
            cell.callBtn.addTarget(self, action: #selector(makeCall), for: .touchUpInside)
            cell.directionBtn.addTarget(self, action: #selector(redirectToMap), for: .touchUpInside)

            cell.comboBtn.addTarget(self, action: #selector(didTapComboClicked), for: .touchUpInside)
            cell.aboutBtn.addTarget(self, action: #selector(didTapAboutOption(sender:)), for: .touchUpInside)

            
            
            
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
        
        if indexPath.row == 4 {
            if  (restModal?.eventparty.count ?? 0) == 0 {
                return 0
            }else{
                return UITableView.automaticDimension
            }
        }
        else if indexPath.row == 5{
            if  (restModal?.menus.count ?? 0) == 0 {
                return 0
            }
            return CGFloat((70 * (restModal?.menus.count ?? 0)) + 40)
        }
        
        else{
            return UITableView.automaticDimension
        }
    }
}
