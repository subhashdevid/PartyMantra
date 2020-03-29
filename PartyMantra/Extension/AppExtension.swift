//
//  StoryBoardExtension.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 19/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    case main = "Main"
    case home = "Home"
    case events = "Events"
    case miscellaneous="Miscellaneous"
    case more = "MoreStoryBoard"
    case datepicker = "DatePicker"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate( appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

extension AppDelegate {
    func showLoginScreen() {
        let vc = LoginViewController.instantiate(appStoryboard: .main
        )
        let nav = UINavigationController.init(rootViewController: vc)
        self.window?.rootViewController = nav
    }

    func showHomeScreen() {
        let vc = TabbarViewController.instantiate(appStoryboard: .home)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}


extension UIView {
    func customButton() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3
        
        self.backgroundColor = UIColor.init(named: "ButtonBlue")
    }
    
    func customButtonForLoginSignUp() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3
        
        self.backgroundColor = UIColor.black
    }
    
}

extension UIViewController {
    func showAlert(title: String = "" ,_ message:String, goBack: Bool = false){
        let alert = UIAlertController(title: title, message:message
            , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            if goBack {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UITextField {
    func customTextFieldWithLeftImage(leftImage: String? = nil) {
        if let image = leftImage {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            let image = UIImage.init(named: image)
            let imageView = UIImageView.init(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = .white
            view.addSubview(imageView)
            self.leftView = view
            self.leftViewMode = .always
        }
        self.backgroundColor = UIColor.init(named: "TextFieldColor")
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.textColor = .white
    }
    
    func addAccessortViewToTextField() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
//        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.clickedDone))
//        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(self.cancelDate))
        toolbar.setItems([done], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc func cancelDate() {
        self.resignFirstResponder()
    }
    
    @objc func clickedDone() {
        self.resignFirstResponder()
    }
}

extension String {

    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }

    //Validate Email

    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }

    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }

    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){

                if(self.count>=6 && self.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    
    var isValidEmail: Bool {
       let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
       return testEmail.evaluate(with: self)
    }
    
//    var isValidPhone: Bool {
//       let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
//       let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
//       return testPhone.evaluate(with: self)
//    }
    
    var isValidPhone: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    
   
}
