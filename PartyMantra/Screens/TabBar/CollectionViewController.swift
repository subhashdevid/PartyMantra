//
//  CollectionViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CollectionViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArr = [HomeCollection]()
    var type: String?
    
    @IBOutlet weak var lblBalance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getCollectionList()
    }
    
    func getCollectionList() {
        var param: [String: Any] = [
            
            :]
        if type != "" {
            param["type"] = self.type
        }
        Loader.showHud()
        NetworkManager.getCollectionListing(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                if let notification = response.data {
                    self?.dataArr = notification.collections ?? []
                    self?.collectionView.reloadData()
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

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: self.view.width, height: 170)
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
            .dequeueReusableCell(withReuseIdentifier: "collectionListCell", for: indexPath) as? collectionListCell
        let notification = dataArr[indexPath.row]
        cell?.configureCell(data: notification)
        collectionCell = cell
        return collectionCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = EventListViewController.instantiate(appStoryboard: .events)
        switch type {
        case "events":
            vc.type = "events"
        case "restaurant":
            vc.type = "restaurants"
            case "party":
                vc.type = "party"
        default:
            vc.type = "events"
        }
        vc.collectionID = dataArr[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


class collectionListCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        imgView.contentMode = .scaleAspectFill
    }
    
    func configureCell(data: HomeCollection) {
        lblTitle.text = data.name
        let url = URL(string: data.cover_image ?? "")
        imgView.kf.setImage(with: url, placeholder: UIImage(named: "applogo_1024"))
    }
}
