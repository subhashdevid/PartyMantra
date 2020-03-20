//
//  HomeViewController.swift
//  PartyMantra
//
//  Created by Mayank Purwar on 15/02/20.
//  Copyright © 2020 Mayank Purwar. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet var topMenuView: UIView!
    var topMenuBar: TopMenuBar!
    var homePageViewController: HomePageViewController?
    fileprivate var selectedIndex: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        addTopMenuView()
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
                
                let list1 = ListViewController.instantiate(appStoryboard: .home)
                list1.type = ""
                
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

