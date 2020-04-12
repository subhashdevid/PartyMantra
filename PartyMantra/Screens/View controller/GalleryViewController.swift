//
//  GalleryViewController.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 08/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Alamofire
import EzPopup



class GalleryViewController: UIViewController {

    var dataArr: [[String : Any]] = [[:]]
    
    @IBOutlet weak var collectionView: UICollectionView!
    var eventId : String?
    var type: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gallerylistEndpointCall()
        
    }

    
    func gallerylistEndpointCall()  {
        
        var reviewType = ""
        if self.type == "events"{
            reviewType = "event"
        }
        else if self.type == "restaurant"{
            reviewType = "restaurant"
        }
        else  if self.type == "party"{
            reviewType = "party"
        }
        
        Loader.showHud()
        let reviewlistEndpoint: String = Server.shared.reviewListUrl + "\(reviewType)" + "/\(eventId ?? "")" + "/gallery"
        
        Alamofire.request(reviewlistEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let data = response.result.value{
                    print(data)
                    Loader.dismissHud()
                    if  (data as? [[String : Any]]) != nil{
                        
                        print(data)

                        self.dataArr.removeAll()
                        
                        for dict in data as? [[String : Any]] ?? [[:]] {
                            print(dict)
                            self.dataArr.append(dict)
                        }
                        self.collectionView.reloadData()
                    }
                }
        }
    }
    
}


extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0.0, height: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as? GalleryCollectionViewCell
        let docString = self.dataArr[indexPath.row]["doc_path"] as? String
        let url = URL(string: docString ?? "")
        cell?.cellImage.contentMode = .scaleAspectFill
        cell?.cellImage.kf.setImage(with: url, placeholder: UIImage(named: "applogo_1024"))
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
     let docString = self.dataArr[indexPath.row]["doc_path"] as? String
               let vc = GalleryWebViewController.instantiate(appStoryboard: .miscellaneous) as GalleryWebViewController
                vc.docString = docString
        let popupVC = PopupViewController(contentController: vc, popupWidth: (UIScreen.main.bounds.size.width)-20, popupHeight: (UIScreen.main.bounds.size.height) - 80)
               popupVC.cornerRadius = 20
               present(popupVC, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 5), height: (collectionView.frame.size.width / 3))
    }
    

}

