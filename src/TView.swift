//
//  TView.swift
//  TSuppot
//
//  Created by Virpik on 28/12/2016.
//  Copyright © 2016 Sybis. All rights reserved.
//

import UIKit

public extension UIView {
    static func default1x1() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    static func default10x10() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    static func default20x20() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    
    static func default50x50() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    static func default100x100() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    static func defaultScreen() -> Self {
        return self.init(frame: UIScreen.main.bounds)
    }
}

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
