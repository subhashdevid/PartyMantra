//
//  UIViewExtension.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 19/03/20.
//  Copyright © 2020 Shikha. All rights reserved.


import UIKit


extension UIView {
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        
        set(newOrigin) {
            self.frame.origin = newOrigin
        }
    }
    
    public var size: CGSize {
        get {
            return self.frame.size
        }
        
        set(newSize) {
            self.frame.size = newSize
        }
    }
    
    public var width: CGFloat {
        get {
            return self.size.width
        }
        
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    
    public var left: CGFloat {
        get {
            return self.origin.x
        }
        
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    
    
    func applyEmbedConstraintsToSubView(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let width = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["subview": subview])
        let height = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["subview": subview])
        
        // self.topAnchor.constraint(equalTo: subview.topAnchor, constant: 10).isActive = true
        
        self.addConstraints(width)
        self.addConstraints(height)
    }
}

