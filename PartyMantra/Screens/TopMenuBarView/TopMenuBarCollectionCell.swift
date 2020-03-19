//
//  TopMenuBarCollectionCell.swift
//  NewsApp
//
//  Created by Apple on 21/10/19.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

class TopMenuBarCollectionCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet fileprivate var selectionIndicator: UIView!
    
    var color = UIColor.red
    var selectedColor = UIColor.green
    
    var fixedWidth: Bool = false
    var selectorIndicatorWidth: Int = 20
    
    var isCircular: Bool = false
    var selectorIndicatorHeight: Int = 2
    
    @IBOutlet weak var widthConst: NSLayoutConstraint!
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    var index: Int = 0
    
    class func sizeForTabTitle(_ title: String) -> CGSize {
        return CGSize(width: TopMenuBarCollectionCell.getWidthForTitle(title: title), height: 40)
    }
    
    func configureTabWithText(_ text: String, fixed: Bool,bottom: Bool, indicatorWidth: Int = 20, isCircle: Bool, height: Int) {
        self.fixedWidth = fixed
        self.isCircular = isCircle
        self.selectorIndicatorHeight = height
        self.titleLabel.text = text
        self.titleLabel.textAlignment = .center
        self.selectorIndicatorWidth = indicatorWidth
        self.titleLabel.font =  UIFont.systemFont(ofSize: 15)
        //  self.titleLabel.textColor = self.topMenuColor(false)
        self.titleLabel.textColor = self.topMenuColor(false)
        
//        isEnglishChar = text.containsOnlyLetters()
//        self.titleLabel.font = isEnglishChar ? self.topMenuEnglishFont(false) : self.topMenuFont(false)
        selectionIndicator.backgroundColor = UIColor.clear
//        selectionIndicator.translatesAutoresizingMaskIntoConstraints = false
        if bottom {
            bottomConst.constant = 0
        }
        if isCircular {
            widthConst.constant = 4
            heightConst.constant = 4
//            selectionIndicator.roundCorners()
        }
    }
    
//    func selectTab(_ cellwidth: CGFloat) {
//        let color = self.topMenuColor(true)
//        selectionIndicator.backgroundColor = color
//        titleLabel.width = TopMenuBarCollectionCell.getWidthForTitle(title: titleLabel.text)
//        self.frame.size.width = cellwidth > 0 ? cellwidth : titleLabel.width
//        titleLabel.textColor = color
////        self.titleLabel.font = isEnglishChar ? self.topMenuEnglishFont(true) : self.topMenuFont(true)
//
//        selectTabFromRect(frame: CGRect.zero)
//    }
    
    func selectTab() {
        let color = self.topMenuColor(true)
        selectionIndicator.backgroundColor = color
//        titleLabel.width = TopMenuBarCollectionCell.getWidthForTitle(title: titleLabel.text)
//        self.frame.size.width = titleLabel.width
        titleLabel.textColor = color
        //        self.titleLabel.font = isEnglishChar ? self.topMenuEnglishFont(true) : self.topMenuFont(true)
        
        selectTabFromRect(frame: CGRect.zero)
    }
    
    func deSelectTab(type: Bool) {
        
        let color = self.topMenuColor(false)
        
        //titleLabel.textColor = hexStringToUIColor(hex: "4A6073")
        titleLabel.textColor = color
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        selectionIndicator.backgroundColor = UIColor.clear
    }
    
    func selectTabFromRect(frame: CGRect) {
        let color = self.topMenuColor(true)
//        let color = Appconstants.BackgroundColor.darkbgColor
        
        titleLabel.textColor = color
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        selectionIndicator.backgroundColor = color
        
//        if fixedWidth {
//            widthConst.constant = frame.width
//        } else {
//            widthConst.constant = CGFloat(selectorIndicatorWidth)
//        }
        
        if isCircular {
            widthConst.constant = 4
            heightConst.constant = 4
//            selectionIndicator.roundCorners()
        }
        
        
        
//        selectionIndicator.width = 100//frame.size.width > 0 ? width : 0
        //selectionIndicator.left = frame.origin.x - self.left
        
//        let width = frame.size.width
//        UIView.animate(withDuration: 0.45, delay: 0, options: UIView.AnimationOptions.beginFromCurrentState, animations: { [weak self] () -> Void in
//            self?.selectionIndicator.center = CGPoint(x: width / 2, y: self?.selectionIndicator.center.y ?? -1000)
//        }) { [weak self] (_: Bool) -> Void in
//            var rect = self?.selectionIndicator.frame ?? CGRect.zero
//            rect.origin.x = 0
//            rect.size.width = (self?.size.width ?? 0)
//            UIView.animate(withDuration: 0.35) { [weak self] () -> Void in
//                self?.selectionIndicator?.frame = rect
//            }
//        }
    }
    
    func topMenuColor(_ isSelected: Bool) -> UIColor {
        return isSelected ? self.selectedColor : self.color
    }
    
    func topMenuFont(_ isSelected: Bool) -> UIFont {
        return isSelected ? UIFont.systemFont(ofSize: 17) : UIFont.systemFont(ofSize: 16)
    }
    
    func topMenuEnglishFont(_ isSelected: Bool) -> UIFont {
        return isSelected ?  UIFont.systemFont(ofSize: 13, weight: .bold) :  UIFont.systemFont(ofSize: 12, weight: .bold)
    }
}


extension TopMenuBarCollectionCell {
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    class func getWidthForTitle(title: String? = "Dummy") -> CGFloat {
        if let title = title {
            let width = (title as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 30 // 10+10 left and right padding
            return width
        }
        return 0.0
    }
}
