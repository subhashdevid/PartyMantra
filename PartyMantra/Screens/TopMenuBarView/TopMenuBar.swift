//
//  TopMenu.swift
//  NewsApp
//
//  Created by Apple on 21/10/19.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

enum TopMenuBarType {
    case fixedWidth
    case flexible
}

typealias TabSelectionHandler = (_ direction: UIPageViewController.NavigationDirection, _ index: Int, _ oldIndex: Int, _ handler: ((_ success: Bool) -> Void)?) -> Void

class TopMenuBar: UIView {
    var items: [String]?
    var currentPage: Int = 0
    
    var topMenuBarType: TopMenuBarType?
    var cellWidth: CGFloat = 0.0
    
    @IBOutlet var topMenuContentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    fileprivate var tabSelectionHandler: TabSelectionHandler?
    var selectorFullWidth: Bool = false
    var selectorAtBottom: Bool = false
    
    var isCircular: Bool = false
    var selectorIndicatorHeight: Int = 2
    
    var selectorIndicatorWidth: Int = 20
    
    func reloadCollectionView() {
        if topMenuBarType == .fixedWidth {
            if let items = items, !items.isEmpty {
                cellWidth = collectionView.width / CGFloat(items.count)
            }
        }
        collectionView.reloadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "\(TopMenuBarCollectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TopMenuBarCollectionCell.self)")
        topMenuContentView.layer.masksToBounds = false
        //        topMenuContentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        //        topMenuContentView.layer.shadowRadius = 2
        //        topMenuContentView.layer.shadowOpacity = 0.5
        //        topMenuContentView.layer.shadowColor = UIColor.lightGray.cgColor
        
        
        
    }
    
    func configureCollectionViewWithTabSelectionChange(handler: @escaping TabSelectionHandler) {
        tabSelectionHandler = handler
        collectionView.isExclusiveTouch = true
        let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.scrollDirection = .horizontal
    }
    
    func performTransitionAnimation(_ pageIndex: Int) {
        if pageIndex != currentPage {
            deselectPreviousTab()
        }
        
        let frameToAnimate = rectOfPreviousTab()
        currentPage = pageIndex
        if let cell = collectionView.cellForItem(at: IndexPath(item: currentPage, section: 0)) as? TopMenuBarCollectionCell {
            cell.selectTabFromRect(frame: frameToAnimate)
        }
        scrollToItemAtIndex(index: currentPage)
    }
    
    func tabSelectionDidChange(_ tabCell: TopMenuBarCollectionCell, handler: ((_ success: Bool) -> Void)?) {
        if tabCell.index == currentPage || tabCell.index > (items?.count ?? 0) {
            return
        }
        let direction = tabCell.index < currentPage ? UIPageViewController.NavigationDirection.reverse : UIPageViewController.NavigationDirection.forward
        
        if let tabSelectionHandler = tabSelectionHandler {
            tabSelectionHandler(direction, tabCell.index, currentPage) { [weak self] success in
                if success {
                    handler?(true)
                    self?.currentPage = tabCell.index
                    self?.scrollToItemAtIndex(index: tabCell.index)
                } else {
                    handler?(false)
                }
            }
        }
    }
}

private extension TopMenuBar {
    func deselectPreviousTab() {
        let cell = collectionView.cellForItem(at: IndexPath(item: currentPage, section: 0)) as? TopMenuBarCollectionCell
        cell?.deSelectTab(type: true)
    }
    
    func rectOfPreviousTab() -> CGRect {
        let cell = collectionView.cellForItem(at: IndexPath(item: currentPage, section: 0)) as? TopMenuBarCollectionCell
        if let cell = cell {
            return cell.frame
        }
        return CGRect.zero
    }
    
    func scrollToItemAtIndex(index: Int) {
        if index == NSNotFound || (index >= items?.count ?? 0) {
            return
        }
        if cellWidth == 0 {
            
            collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
    }
    
//    func selectedColor(index: Int) -> UIColor? {
//        if isFromHomeTab {
//            if let tabContents = tabContents, tabContents.count > index {
//                if let v = tabContents[index].categoryColorFromSideMenu(), v.hexString != "#ffffff" {
//                    return v
//                }
//                return navbarSelecteColor
//            }
//        }
//        return navbarSelecteColor
//    }
}

extension TopMenuBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = items {
            return items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TopMenuBarCollectionCell.self)", for: indexPath as IndexPath) as? TopMenuBarCollectionCell
        cell?.index = indexPath.row
        
//        cell?.setColor(itemColor: navbarItemColor, selectedColor: selectedColor(index: indexPath.row))
        
        if let items = items {
            cell?.configureTabWithText(items[indexPath.row], fixed: selectorFullWidth, bottom: selectorAtBottom, indicatorWidth: selectorIndicatorWidth,isCircle: isCircular, height: selectorIndicatorHeight)
        }
        if indexPath.row == currentPage {
            cell?.selectTab()
        } else {
            cell?.deSelectTab(type: false)
        }
        return cell ?? UICollectionViewCell()
    }
}

extension TopMenuBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize = CGSize.zero
        switch topMenuBarType {
        case .fixedWidth?:
            guard let items = items else {
                return CGSize.zero
            }
            size = CGSize(width: self.width / CGFloat(items.count), height: 40)

        default:
            if let items = items {
                size = TopMenuBarCollectionCell.sizeForTabTitle(items[indexPath.row])
            }
            if cellWidth > 0 {
                size.width = cellWidth
            }
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return topMenuBarType == .fixedWidth ? 0 : 10
//        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return topMenuBarType == .fixedWidth ? 0 : 10
//        return 10
    }
}

extension TopMenuBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TopMenuBarCollectionCell
        if let cell = cell {
            if cell.index != currentPage {
                tabSelectionDidChange(cell) { [weak self] success in
                    if success, let strongSelf = self {
                        strongSelf.deselectPreviousTab()
                        cell.selectTabFromRect(frame: strongSelf.rectOfPreviousTab())
                    }
                }
            }
        }
    }
}

