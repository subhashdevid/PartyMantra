//
//  HomePageViewController.swift
//  NewsApp
//
//  Created by Apple on 21/10/19.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

class HomePageViewController: UIPageViewController {
    var pageindex: Int = 0
    var model: Any?
    var subCategoryTitle: String?
    var info: [String: Any]?
//    var tabContents: [CategoryModel]?
    
    var setNextPage: ((_ pageIndex: Int) -> Void)?
    var controllersDictionary: [BaseViewController] = []
    private var shouldTabTappable = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
//        self.view.backgroundColor = Appconstants.BackgroundColor.bgColor
        setUpPage(pageindex, .forward)
        addDummyView()
        NotificationCenter.default.addObserver(self, selector: #selector(enableSwipe(notification:)), name: NSNotification.Name(rawValue: "enableSwipedPaging"), object: nil)
//
        NotificationCenter.default.addObserver(self, selector: #selector(disableSwipe(notification:)), name: NSNotification.Name(rawValue: "disableSwipePaging"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    @objc func disableSwipe(notification _: NSNotification) {
        dataSource = nil
       
        for recognizer in gestureRecognizers {
            recognizer.isEnabled = false
        }
    }
    
    @objc func enableSwipe(notification _: NSNotification) {
        dataSource = self
        
    
        for recognizer in gestureRecognizers {
            recognizer.isEnabled = true
        }
    }
    
    func addDummyView() {
        let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: UIScreen.main.bounds.height))
        dummyView.backgroundColor = UIColor.clear
        view.addSubview(dummyView)
    }
    
    func setUpPage(_ index: Int, _ direction: UIPageViewController.NavigationDirection, _ handler: ((_ success: Bool) -> Void)? = nil) {
        if shouldTabTappable, let vc = getViewControllerAtIndex(index: index) {
            handler?(true)
            DispatchQueue.main.async { [weak self] in
                self?.setViewControllers([vc],
                                         direction: direction,
                                         animated: true,
                                         completion: { (finished) -> Void in
                                                             // Setting the view controller programmatically does not fire
                                                             // any delegate methods, so we have to manually notify the
                                                             // 'tutorialDelegate' of the new index.
                                            self?.setNextPage?(self?.pageindex ?? 0)
                                         })
            }
        } else {
            handler?(false)
        }
    }
    
    func reload() {
//        self.tabContents = tabContents
        controllersDictionary.removeAll()
        pageindex = 0
        setUpPage(pageindex, .forward)
    }
    
    // MARK: - Private methods
    
    fileprivate func getViewControllerAtIndex(index: NSInteger) -> BaseViewController? {
        // Create a new view controller and pass suitable data.
         pageindex = index
//        if let controller = controllersDictionary[index] {
//            return controller
//        }
        if index >= controllersDictionary.count {
            return nil
        }
        
        let controller = controllersDictionary[index]
        controller.pageIndex = index
        return controller
               
//        guard let tabContents = tabContents, tabContents.count > index else {
//            return nil
//        }
//        let item = tabContents[index]
//        var val = info ?? [:]
//        val[AppConstants.parent] = model
//
//        if let subCatTitle = subCategoryTitle {
//            val["SubcategoryTitle"] = subCatTitle
//        }
        
        
       
        
//        if let pageContentViewController = UIViewController.controller(for: URLType.news.rawValue, with: item, url: nil, info: val) as? BaseViewController {
//
//            pageContentViewController.pageIndex = index
//            controllersDictionary[index] = pageContentViewController
//            return pageContentViewController
//        }
//        return nil
    }
}

extension HomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = Int()
        if let pageContent = viewController as? BaseViewController {
            index = pageContent.pageIndex
        }
        if index == 0 || index == NSNotFound {
            return nil
        }
        index -= 1
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = Int()
        if let pageContent = viewController as? BaseViewController {
            index = pageContent.pageIndex
        }
        if index == NSNotFound {
            return nil
        }
        index += 1

        return getViewControllerAtIndex(index: index)
    }
}

extension HomePageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating _: Bool,
                            previousViewControllers _: [UIViewController],
                            transitionCompleted completed: Bool) {
        shouldTabTappable = true
        guard completed, let viewControllers = pageViewController.viewControllers, let pageContentViewController = viewControllers.first as? BaseViewController else { return }
        setNextPage?(pageContentViewController.pageIndex)
        // pageViewController.viewControllers!.first!.view.tag
    }
    
    func pageViewController(_: UIPageViewController, willTransitionTo _: [UIViewController]) {
        
        shouldTabTappable = false
    }
    
}
