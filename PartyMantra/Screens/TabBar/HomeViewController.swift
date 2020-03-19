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
        addTopMenuView()
    }
    
    
    
    // method to add comment textfield view
    //        private func addTopMenuView() {
    //            if let customView = Bundle.main.loadNibNamed("TopMenuBar", owner: self, options: nil)?.first as? TopMenuBar {
    //
    //                topMenuBar?.removeFromSuperview()
    //                topMenuBar = customView
    //    //            topMenuBar.isFromHomeTab = isHomeTab
    //                topMenuView.addSubview(topMenuBar)
    //                topMenuView.applyEmbedConstraintsToSubView(topMenuBar)
    //                topMenuView.layoutIfNeeded()
    //                topMenuView.layoutSubviews()
    //                topMenuBar.topMenuBarType = .fixedWidth
    //
    //                topMenuBar.items = ["dfg", "dfg", "gdfg"]
    //                topMenuBar.reloadCollectionView()
    //                topMenuBar.configureCollectionViewWithTabSelectionChange { [weak self] (direction, index, _, handler) -> Void in
    //                    self?.homePageViewController?.setUpPage(index, direction, handler)
    //                }
    //                if let selectedIndex = selectedIndex, selectedIndex != 0 {
    //                    topMenuBar.performTransitionAnimation(selectedIndex)
    //                }
    //            }
    //        }
    
    private func addTopMenuView() {
        if let customView = Bundle.main.loadNibNamed("TopMenuBar", owner: self, options: nil)?.first as? TopMenuBar {
            
            //                print(tabContents)
            customView.backgroundColor = .clear
            topMenuBar?.removeFromSuperview()
            topMenuBar = customView
            //            topMenuBar.isFromHomeTab = isHomeTab
            topMenuView.addSubview(topMenuBar)
            topMenuView.applyEmbedConstraintsToSubView(topMenuBar)
            topMenuView.layoutIfNeeded()
            topMenuView.layoutSubviews()
            topMenuView.backgroundColor = .clear
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
    
    //    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
    //        if segue.identifier == "SearchController" {
    //            if let homePageViewController = segue.destination as? HomePageViewController {
    //
    //
    //                if let cont = controller {
    //
    //                    homePageViewController.controllersDictionary = cont
    //                }
    //
    //                else {
    //
    //                    let proTalksVC = ProTalksViewController.instantiate(fromAppStoryboard:.main)
    //                    proTalksVC.isComingFromSearch = true
    //
    //                    let critiQueVC =  CritiqueViewController.instantiate(fromAppStoryboard:.main)
    //                    critiQueVC.isComingFromSearch = true
    //
    //                    let otherVC =   OtherViewController.instantiate(fromAppStoryboard: .main)
    //                    otherVC.isComingFromSearch = true
    //
    //                    homePageViewController.controllersDictionary = [UsersViewController.instantiate(fromAppStoryboard: .search),proTalksVC,
    //                        critiQueVC, otherVC]
    //                }
    //
    //                homePageViewController.pageindex = selectedIndex ?? 0
    //                self.homePageViewController = homePageViewController
    //                self.homePageViewController?.setNextPage = { [weak self] pageIndex in
    //                    self?.topMenuBar.performTransitionAnimation(pageIndex)
    //                    self?.searchHomeView.crossClicked()
    //                }
    //            }
    //        }
    //    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "homePageController" {
            if let homePageViewController = segue.destination as? HomePageViewController {
                
                let list1 = ListViewController.instantiate(appStoryboard: .home)
                list1.type = ""
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

