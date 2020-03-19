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
        
        if isKeyboardNotificationsEnabled() {
            registerKeyboardNotificaitons()
        }
        // Do any additional setup after loading the view.
    }
    
    func AddHamBurgerButton() {
//        let button = UIButton.init(type: .custom)
//        button.setImage(UIImage.init(named: "Hamburger"), for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//        
//        let barButton = UIBarButtonItem.init(customView: button)
//        self.navigationItem.leftBarButtonItem = barButton
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
    
    func isKeyboardNotificationsEnabled() -> Bool {
        return false
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
    
}

extension BaseViewController {
    

    // MARK: - Keyboard Observer
    
    func registerKeyboardNotificaitons() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Keyboard Notification handler methods
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomInset = keyboardSize.height-50
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
            viewForScrolling()?.contentInset = contentInsets
            viewForScrolling()?.scrollIndicatorInsets = contentInsets
        }
//        isShowingKeyboard = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      
            setScrollViewContentOffset(offset: 0)
//            viewForScrolling()?.contentInset = UIEdgeInsets.zero
//            viewForScrolling()?.scrollIndicatorInsets = UIEdgeInsets.zero
            //  scrollView()?.setContentOffset(CGPoint.zero, animated: true)
        
//        isShowingKeyboard = false
    }

    func setScrollViewContentOffset(offset: CGFloat) {
        if var currentContentInset = viewForScrolling()?.contentInset {
            currentContentInset.bottom = offset
            viewForScrolling()?.contentInset = currentContentInset
            viewForScrolling()?.scrollIndicatorInsets = currentContentInset
        }
//        setUpBottomLayout(offset: offset)
    }}
