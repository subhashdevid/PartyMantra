//
//  CollectionDetailViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CollectionDetailViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    var eventArr = [eventModel]()
    var diningArr = [restaurantModel]()
    var partyArr = [PartyModel]()
    var type: String?
    var collectionID: Int?
    
    @IBOutlet weak var lblBalance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch type {
        case "events":
            getCollectionClubDetailList()
        case "restaurants":
            getCollectionDiningDetailList()
            case "party":
                getCollectionPartiesDetailList()
        default:
            getCollectionClubDetailList()
        }
    }
    
    func createUrl() -> String {
        let param: [String: Any] = [
            
            :]
        var url = ""
        if let collectionID = collectionID {
            url = Server.shared.collectionDetailUrl + "/\(collectionID)/" + "\(type ?? "")"
        }
        return url
    }
    
    func getCollectionClubDetailList() {
        Loader.showHud()
        let param: [String: Any] = [
            
            :]
        NetworkManager.getCollectionClubDetailListing(url: createUrl(),parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                if let notification = response.data {
                    self?.eventArr = notification.events ?? []
                    self?.collectionView.reloadData()
                    
                    let url = URL(string: notification.image ?? "")
                    self?.imageView.kf.setImage(with: url, placeholder: nil)
                }
                
            case .failure: break
            }
        }
    }
    
    func getCollectionDiningDetailList() {
        let param: [String: Any] = [
            
            :]
        Loader.showHud()
        NetworkManager.getCollectionDiningDetailListing(url: createUrl(),parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                if let notification = response.data {
                    self?.diningArr = notification.events ?? []
                    self?.collectionView.reloadData()
                    
                    let url = URL(string: notification.image ?? "")
                    self?.imageView.kf.setImage(with: url, placeholder: nil)
                }
                
            case .failure: break
            }
        }
    }
    
    func getCollectionPartiesDetailList() {
        let param: [String: Any] = [
            
            :]
        Loader.showHud()
        NetworkManager.getCollectionPartiesDetailListing(url: createUrl(),parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                if let notification = response.data {
                    self?.partyArr = notification.events ?? []
                    self?.collectionView.reloadData()
                    
                    let url = URL(string: notification.image ?? "")
                    self?.imageView.kf.setImage(with: url, placeholder: nil)
                }
                
            case .failure: break
            }
        }
    }
    
    
    @IBAction func clickedAddMoney() {
        
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

extension CollectionDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: self.view.width, height: 130)
     }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count = 0
        
        switch type {
        case "events":
            count = eventArr.count
        case "restaurants":
            count = diningArr.count
        case "party":
            count = partyArr.count
        default:
            count = 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectionCell: UICollectionViewCell?
        
        switch type {
        case "events":
                    let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "collectionDetailEventCell", for: indexPath) as? collectionDetailEventCell
            let notification = eventArr[indexPath.row]
            cell?.configureCell(data: notification)
            
            collectionCell = cell
        case "restaurants":
                    let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "collectionDetailClubCell", for: indexPath) as? collectionDetailClubCell
            let notification = diningArr[indexPath.row]
            cell?.configureDiningCell(data: notification)
            
            collectionCell = cell
        case "party":
                   let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "collectionDetailClubCell", for: indexPath) as? collectionDetailClubCell
            let notification = partyArr[indexPath.row]
            cell?.configurePartyCell(data: notification)
            
            collectionCell = cell
        default:
            collectionCell = UICollectionViewCell()
        }
        
        
        
        
        
        

        
        return collectionCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailViewController.instantiate(appStoryboard: .home) as DetailViewController
//        vc.product = dataArr[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


class collectionDetailClubCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDec: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
     @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        imgView.contentMode = .scaleAspectFill
    }
    
    func configureDiningCell(data: restaurantModel) {
        lblTitle.text = data.name
        lblDec.text = data.description
        lblPrice.text = data.per_person_text
        lblRating.text = "\(data.raing ?? 0)"
        
        let url = URL(string: data.small_image ?? "")
        imgView.kf.setImage(with: url, placeholder: nil)
    }
    
    func configurePartyCell(data: PartyModel) {
                lblTitle.text = data.name
        lblDec.text = data.description
        lblPrice.text = data.per_person_text
        lblRating.text = "\(data.raing ?? 0)"
        let url = URL(string: data.small_image ?? "")
        imgView.kf.setImage(with: url, placeholder: nil)
    }
}

class collectionDetailEventCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDec: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblvenue_adderss: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAway: UILabel!
    @IBOutlet weak var lblStarted: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        imgView.contentMode = .scaleAspectFill
    }
    
    func configureCell(data: eventModel) {
        lblTitle.text = data.title
        lblDec.text = data.venue_name
        lblPrice.text = data.per_person_text
        lblvenue_adderss.text = data.venue_adderss
        lblDate.text = data.startdate
        lblAway.text = "\(data.away ?? 0)"
        lblStarted.text = data.time_to_start
        
        lblRating.text = "\(data.rating ?? 0)"
        let url = URL(string: data.small_image ?? "")
        imgView.kf.setImage(with: url, placeholder: nil)
    }
}
