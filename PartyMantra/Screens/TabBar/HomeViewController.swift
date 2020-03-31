//
//  HomeViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UISearchBarDelegate , AddressChangeDelegate {
    
    @IBOutlet var topMenuView: UIView!
    
    @IBOutlet var topAddressView: UIView!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var changeBtn: UIButton!
    
    var profile : ProfileModel?
    var topMenuBar: TopMenuBar!
    var homePageViewController: HomePageViewController?
    fileprivate var selectedIndex: Int?
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        topAddressView.backgroundColor = .white
        
        
        UserDefaults.standard.set("1", forKey: "ISLOGIN") //setObject
        UserDefaults.standard.synchronize()
        
        
        addTopMenuView()
        
        
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search by Restaurant..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        self.changeBtn.addTarget(self, action: #selector(changedAddressAction), for: .touchUpInside)
    }
    
    //MARK:- AddressChange Delegate
    func returnChangedAddress(address: String, latitude: String, longitude: String) {
        self.addressLbl.text = address
        
        UserDetails.shared.set_address(address )
        UserDetails.shared.set_address_lat(latitude )
        UserDetails.shared.set_address_long(longitude )
        UserDefaults.standard.synchronize()
        
    }
    
    @objc func changedAddressAction()  {
        
        let addressVC = AddressSearchViewController.instantiate(appStoryboard: .miscellaneous) as AddressSearchViewController
        
        addressVC.delegateAddress = self
        addressVC.post_title = "Select Address"
        addressVC.post_screen = "home"
        self.navigationController?.pushViewController(addressVC, animated: true)
    }
    
    
    func fetchUserProfile() {
        let accessUserToken =  UserDefaults.standard.string(forKey: "AccessToken")
        let param: [String: Any] = [
            "token":accessUserToken ?? ""
        ]
        Loader.showHud()
        NetworkManager.getProfile(parameters: param) {[weak self] result in
            Loader.dismissHud()
            switch result {
            case let .success(response):
                if let userProfile = response.data {
                    self?.profile = userProfile
                    self?.addressLbl.text = self?.profile?.address
                    
                }
                
            case .failure: break
            }
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print(searchBar.text)
        self.redirectToSearchScreen(searchStr: searchBar.text ?? "")
    }
    
    func redirectToSearchScreen(searchStr : String) -> Void {
        
        let searchVc = EventSearchViewController.instantiate(appStoryboard: .miscellaneous) as EventSearchViewController
        searchVc.searchedString = searchStr
        self.navigationController?.pushViewController(searchVc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchUserProfile()              
        self.navigationItem.title = "Party Mantra"
        
    }
    
    
    private func addTopMenuView() {
        if let customView = Bundle.main.loadNibNamed("TopMenuBar", owner: self, options: nil)?.first as? TopMenuBar {
            
            //                print(tabContents)
            customView.backgroundColor = .white
            topMenuBar?.removeFromSuperview()
            topMenuBar = customView
            topMenuView.addSubview(topMenuBar)
            topMenuView.applyEmbedConstraintsToSubView(topMenuBar)
            topMenuView.layoutIfNeeded()
            topMenuView.layoutSubviews()
            topMenuView.backgroundColor = .white
            topMenuBar.topMenuBarType = .fixedWidth
            topMenuBar.items =  ["Club Events", "Dining", "Parties"]
            topMenuBar.reloadCollectionView()
            topMenuBar.configureCollectionViewWithTabSelectionChange { [weak self] (direction, index, _, handler) -> Void in
                self?.homePageViewController?.setUpPage(index, direction, handler)
            }
            if let selectedIndex = selectedIndex, selectedIndex != 0 {
                topMenuBar.performTransitionAnimation(selectedIndex)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "homePageController" {
            if let homePageViewController = segue.destination as? HomePageViewController {
                
                let list1 = ClubEventViewController.instantiate(appStoryboard: .home)
                list1.type = "event"
                
                //                let list1 = EventListViewController.instantiate(appStoryboard: .home)
                //                list1.type = ""
                
                let list2 = DiningViewController.instantiate(appStoryboard: .home)
                list2.type = "restaurant"
                let list3 = PartiesViewController.instantiate(appStoryboard: .home)
                list3.type = "party"
                homePageViewController.controllersDictionary = [list1,list2,list3]
                //                    homePageViewController.model = model
                //                    homePageViewController.info = info
                //                if let tabItems = tabContents {
                //                    for (index, val) in tabItems.enumerated() {
                //                        let label = val.nameInEnglish
                //                        if label == info?["SubcategoryTitle"] as? String {
                //                            selectedIndex = index
                //                        }
                //                    }
                //                }
                homePageViewController.pageindex = selectedIndex ?? 0
                self.homePageViewController = homePageViewController
                self.homePageViewController?.setNextPage = { [weak self] pageIndex in
                    self?.topMenuBar.performTransitionAnimation(pageIndex)
                }
            }
        }
    }
    
}

