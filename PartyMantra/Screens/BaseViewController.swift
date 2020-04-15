//
//  BaseViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 19/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Kingfisher

class BaseViewController: UIViewController {
    var pageIndex: Int = 0
    var currentTF: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "ViewBGColor")
    }
    
    
    func setUpTabBarAndNavigationTitle(tabBarHidden : Bool, navigationTitle : String?) {
        self.tabBarController?.tabBar.isHidden = tabBarHidden
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationItem.title = navigationTitle
    }
    
    
    func addRightButtons() {
        let buttonBell = UIButton.init(type: .custom)
        buttonBell.setImage(UIImage.init(named: "LocationImage"), for: .normal)
        buttonBell.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let barButton = UIBarButtonItem.init(customView: buttonBell)
        
        let buttonLocation = UIButton.init(type: .custom)
        buttonLocation.setImage(UIImage.init(named: "BellImage"), for: .normal)
        buttonLocation.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let barButton1 = UIBarButtonItem.init(customView: buttonLocation)

        self.navigationItem.rightBarButtonItems = [barButton,barButton1]
    }
    
    func addLeftBackButton() {
       let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "BackArrow"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton

    }

    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func viewForScrolling() -> UIScrollView? {
        return nil
    }
    
    func setNavBarTitle(title: String) {
        self.navigationItem.title = title

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func downloadImage(imageView: UIImageView, urlStr: String) {
        if let url = URL(string: urlStr ) {
        imageView.kf.setImage(with: url, placeholder: Constants.defaultUserImage) { result in
            // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
            switch result {
            case .success(let value):
                // The image was set to image view:
                print(value.image)

                // From where the image was retrieved:
                // - .none - Just downloaded.
                // - .memory - Got from memory cache.
                // - .disk - Got from disk cache.
                print(value.cacheType)

                // The source object which contains information like `url`.
                print(value.source)
                imageView.image = value.image

            case .failure(let error):
                print(error) // The error happens
                imageView.image = Constants.defaultUserImage
            }
        }
        } else {
            imageView.image = Constants.defaultUserImage
        }
    }
    
    
    func openMapForRedirection(lat :String , long : String) {
          let latitude = Double(lat) ?? 0.0
          let longitude = Double(long) ?? 0.0
          
          let appleURL = "http://maps.apple.com/?daddr=\(latitude),\(longitude)"
          let googleURL = "comgooglemaps://?daddr=\(latitude),\(longitude)&directionsmode=driving"
          let wazeURL = "waze://?ll=\(latitude),\(longitude)&navigate=false"
          
          let googleItem = ("Google Map", URL(string:googleURL)!)
          let wazeItem = ("Waze", URL(string:wazeURL)!)
          var installedNavigationApps = [("Apple Maps", URL(string:appleURL)!)]
          
          if UIApplication.shared.canOpenURL(googleItem.1) {
              installedNavigationApps.append(googleItem)
          }
          
          if UIApplication.shared.canOpenURL(wazeItem.1) {
              installedNavigationApps.append(wazeItem)
          }
          
          let alert = UIAlertController(title: "Selection", message: "Select Navigation App", preferredStyle: .actionSheet)
          for app in installedNavigationApps {
              let button = UIAlertAction(title: app.0, style: .default, handler: { _ in
                  UIApplication.shared.open(app.1, options: [:], completionHandler: nil)
              })
              alert.addAction(button)
          }
          let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          alert.addAction(cancel)
          present(alert, animated: true)
          
      }

    
    
    
}
