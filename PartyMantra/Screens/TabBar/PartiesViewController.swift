//
//  PartiesViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class PartiesViewController: BaseViewController, PartyOtherCellDelegate, ClubEventCollectionCellDelegate,NearByCollectionCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArr: HomeModel?
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPartyList()
    }
    
    
    func fetchPartyList() {
        var param: [String: Any] = [
            "lat" : UserDetails.shared.get_address_latitude(),
            "lang": UserDetails.shared.get_address_longitude()
        ]
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
    
    func didNearByEventCellPressed(eventID: Int) {
          let vc = EventDetailsViewController.instantiate(appStoryboard: .events) as EventDetailsViewController
                 vc.eventID = eventID
        vc.type = "party"
                 self.navigationController?.pushViewController(vc, animated: true)
      }
      
      
        func didCollectionEventCellPressed(eventID: Int) {
            let vc = EventListViewController.instantiate(appStoryboard: .events)
                   vc.type = "party"
                   vc.collectionID = eventID
                   self.navigationController?.pushViewController(vc, animated: true)
        }
      
    func didPartyCellPressed(eventID: Int) {
        let vc = EventDetailsViewController.instantiate(appStoryboard: .events) as EventDetailsViewController
        vc.eventID = eventID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

extension PartiesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        
        if dataArr?.nearby?.count != 0 {
            if indexPath.section == 0 {
                return CGSize(width: self.view.width, height: 200)
            }
            else if indexPath.section == 1 || indexPath.section == 2 {
                return CGSize(width: self.view.width, height: 150)
            }
            else if indexPath.section == 2 {
                
                let data = dataArr?.others?[indexPath.row]
                let count1: Int = data?.party?.count ?? 0
                let count2: Int = data?.banners?.count ?? 0
                
                var rowCount = count1/3
                
                if count1 % 3 != 0 {
                    rowCount = rowCount + 1
                }
                let rowCount1 = count2 > 0 ? 1: 0
                return CGSize(width: self.view.width, height: CGFloat(rowCount * 140) + CGFloat(rowCount1 * 181) + 40.0)
                //3
            }
        }
        else {
            if indexPath.section == 0 {
                return CGSize(width: self.view.width, height: 200)
            }
            else if indexPath.section == 1{
                return CGSize(width: self.view.width, height: 150)
            }
            else if indexPath.section == 2 {
                
                let data = dataArr?.others?[indexPath.row]
                let count1: Int = data?.party?.count ?? 0
                let count2: Int = data?.banners?.count ?? 0
                
                var rowCount = count1/3
                
                if count1 % 3 != 0 {
                    rowCount = rowCount + 1
                }
                let rowCount1 = count2 > 0 ? 1: 0
                return CGSize(width: self.view.width, height: CGFloat(rowCount * 140) + CGFloat(rowCount1 * 181) + 40.0)
                //3
            }
        }
        
        
        
        return CGSize(width: self.view.width, height: 150)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if dataArr?.nearby?.count != 0 {
            return 4
        }
        else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if dataArr?.nearby?.count != 0 {
            if section == 0 {
                return 1
            } else if section == 1  || section == 2{
                return 1
            } else if section == 3 {
                return dataArr?.others?.count ?? 0
            }
        }else{
            if section == 0 {
                return 1
            } else if section == 1 {
                return 1
            } else if section == 2 {
                return dataArr?.others?.count ?? 0
            }
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
        
        if dataArr?.nearby?.count != 0 {
            if indexPath.section == 0 {
                let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: "\(ImageBannerCell.self)", for: indexPath) as? ImageBannerCell
                cell?.configureCell(imgData: dataArr?.banners ?? [])
                collectionCell = cell
            }
                else if indexPath.section == 1{
                              let cell = collectionView
                                                 .dequeueReusableCell(withReuseIdentifier: "NearByCollectionCell", for: indexPath) as? NearByCollectionCell
                                            
                                             cell?.configureCell(nearByPlaceModel: self.dataArr?.nearby ?? [])
                                             cell?.viewButton.addTarget(self, action: #selector(viewCollection), for: .touchUpInside)
                                             
                                             collectionCell = cell
                              cell?.nearbyCell_delegate = self as NearByCollectionCellDelegate
                              
                          }
            else if indexPath.section == 2{
                let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: "\(EventCollectionCell.self)", for: indexPath) as? EventCollectionCell
                cell?.configureCell(imgData: dataArr?.collections ?? [])
                cell?.viewButton.addTarget(self, action: #selector(viewCollection), for: .touchUpInside)
                cell?.club_delegate = self
                collectionCell = cell
           
            }
            else if indexPath.section == 3 {
                let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: "\(PartyOtherCell.self)", for: indexPath) as? PartyOtherCell
                cell?.configureCell(homeOthers: dataArr?.others?[indexPath.row])
                cell?.viewButton.tag = indexPath.row
                cell?.viewButton.addTarget(self, action: #selector(viewEvent(sender:)), for: .touchUpInside)
                collectionCell = cell
            }
        }
        else{
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
                cell?.club_delegate = self

            }
            else if indexPath.section == 2 {
                let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: "\(PartyOtherCell.self)", for: indexPath) as? PartyOtherCell
                cell?.configureCell(homeOthers: dataArr?.others?[indexPath.row])
                cell?.viewButton.tag = indexPath.row
                cell?.viewButton.addTarget(self, action: #selector(viewEvent(sender:)), for: .touchUpInside)
                collectionCell = cell
            }
        }
        
        
        
        return collectionCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
     @objc func viewCollection() {
           let vc = CollectionViewController.instantiate(appStoryboard: .home) as CollectionViewController
           vc.type = "party"
           self.navigationController?.pushViewController(vc, animated: true)
       }
       @objc func viewEvent(sender: UIButton) {
           let vc = CollectionViewController.instantiate(appStoryboard: .home) as CollectionViewController
           vc.type = "party"
           self.navigationController?.pushViewController(vc, animated: true)
       }
       
}

class PartyOtherCell1: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    var eventData: eventModel?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var rateImg: UIImageView!
    
    
    func configureCell(partydata:PartyModel?) {
        lblName.text = partydata?.name
        lblDesc.text = partydata?.short_address
        let url = URL(string: partydata?.small_image ?? "")
        imgView.contentMode = .scaleAspectFill
        imgView.kf.setImage(with: url, placeholder: nil)
        
        if partydata?.avgreviews?.count ?? 0 > 0 {
            rateView.isHidden = false
            rateLbl.isHidden = false
            rateImg.isHidden = false
            rateImg.image = UIImage(named: "starnew")
            
            let rate = partydata?.avgreviews?[0]
            let value = Double(rate?.rating ?? "0.0")
            rateLbl.text = String(format:"%.1f", value ?? 0.0)
        
        }else{
            rateView.isHidden = true
            rateLbl.isHidden = true
            rateImg.isHidden = true
        }
    }
}


protocol PartyOtherCellDelegate: class {
    func didPartyCellPressed(eventID: Int)
}

class PartyOtherCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var homeOthers: HomeOthers?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    weak var party_delegate:PartyOtherCellDelegate?

    func configureCell(homeOthers:HomeOthers?) {
        lblName.text = homeOthers?.name
        lblDesc.text = homeOthers?.about
        
        viewButton.layer.cornerRadius = 10
        viewButton.layer.masksToBounds = true
        self.homeOthers = homeOthers
        collectionView.reloadData()
    }
    
    func cellPressAction(row : Int) {
           if let del = self.party_delegate {
               del.didPartyCellPressed(eventID: row)
           }
       }
}
extension PartyOtherCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return homeOthers?.party?.count ?? 0
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
                .dequeueReusableCell(withReuseIdentifier: "\(PartyOtherCell1.self)", for: indexPath) as? PartyOtherCell1
//            cell?.configureCell(data: self.homeOthers?.party?[indexPath.row])
            cell?.configureCell(partydata: self.homeOthers?.party?[indexPath.row])
        
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
