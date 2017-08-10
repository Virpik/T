//
//  TView.swift
//  TSuppot
//
//  Created by Virpik on 28/12/2016.
//  Copyright © 2016 Sybis. All rights reserved.
//

import UIKit

public extension UIView {
    func printSubViews(q: String) {
        
        print(q, self)
        
        self.subviews.forEach({
            $0.printSubViews(q: q+q)
        })
    }
    
    func subview<T: UIView>() -> T? {
        if let result = self as? T {
            return result
        }
        
        for view in self.subviews {
            if let result: T = view.subview() {
                return result
            }
        }
        
        return nil
    }
}

public extension UIView {
    public func renderImage() -> UIImage? {
        
        self.layoutIfNeeded()
        
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            self.layer.render(in: context)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return image
        }
        
        return nil
    }
}

public extension UIView {
    @IBInspectable public var tBRadius: Float {
        get {
            return self.layer.cornerRadius.float
        }
        
        set (value) {
            self.layer.cornerRadius = value.cgFloat
        }
    }
    
    @IBInspectable public var tBColor: UIColor? {
        get {
            
            if let cgColor = self.layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            
            return nil
        }
        
        set (value) {
            self.layer.borderColor = value?.cgColor
        }
    }
    
    @IBInspectable public var tBWidth: Float {
        get {
            return self.layer.borderWidth.float
        }
        
        set (value) {
            self.layer.borderWidth = value.cgFloat
        }
    }
}
