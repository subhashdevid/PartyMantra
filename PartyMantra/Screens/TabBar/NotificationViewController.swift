//
//  NotificationViewController.swift
//  PartyMantra
//
//  Created by Mayank Purwar on 15/02/20.
//  Copyright © 2020 Mayank Purwar. All rights reserved.
//

import UIKit

class NotificationViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArr = [notificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getNotification()
    }
    
    func getNotification() {
        let param: [String: Any] = [
            
            :]
        Loader.showHud()
        NetworkManager.getNotification(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                print(response)
                if let notification = response.data {
                    self?.dataArr = notification
                    self?.collectionView.reloadData()
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

extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return size(indexPath: indexPath)
     }

     private func size(indexPath: IndexPath) -> CGSize {
         // load cell from Xib
         let cell = collectionView
         .dequeueReusableCell(withReuseIdentifier: "NotificationCell", for: indexPath) as? NotificationCell

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
            .dequeueReusableCell(withReuseIdentifier: "NotificationCell", for: indexPath) as? NotificationCell
        let notification = dataArr[indexPath.row]
        cell?.configureCell(data: notification)

        

      //  let url = URL(string: brand.image ?? "" )
      //  cell?.imgView.kf.setImage(with: url, placeholder: nil)
        
        collectionCell = cell
        
        return collectionCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailViewController.instantiate(appStoryboard: .home) as DetailViewController
//        vc.product = dataArr[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


class NotificationCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    func configureCell(data: notificationModel) {
        lblTitle.text = data.title
        lblDesc.text = data.description
        lblDate.text = data.date
    }
}
