//
//  HomeViewController.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 21/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet var topMenuView: UIView!
    
    @IBOutlet var topAddressView: UIView!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var changeBtn: UIButton!
    
    
    var topMenuBar: TopMenuBar!
    var homePageViewController: HomePageViewController?
    fileprivate var selectedIndex: Int?
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        topAddressView.backgroundColor = .white
        addressLbl.text = "AIG Gaur City Gautam Budh Nagar UP"
        
        addTopMenuView()
        
        
        
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search by Restaurant..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
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
    
    override func viewWillAppear(_ animated: Bool) {
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

