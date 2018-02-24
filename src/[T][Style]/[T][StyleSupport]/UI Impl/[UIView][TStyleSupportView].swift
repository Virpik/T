//
//  TStyleSupportUIView.swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension UIView: TStyleSupportView {
    @objc public dynamic var aBackgroundColor: UIColor {
        get {
            return self.backgroundColor ?? .clear
        }
        
        set (value) {
            self.backgroundColor = value
        }
    }
    
    @objc public dynamic var aAlpha: CGFloat {
        get {
            return self.alpha
        }
        
        set (value) {
            self.alpha = 1
        }
    }
    
    @objc public dynamic var aBordeWidth: CGFloat {
        get {
            return self.tBWidth.cgFloat
        }
        
        set (value) {
            self.tBWidth = value.float
        }
    }
    
    @objc public dynamic var aCornerRadius: CGFloat {
        get {
            return self.tBRadius.cgFloat
        }
        
        set (value) {
            self.tBRadius = value.float
        }
    }
    
    @objc public dynamic var aBorderColor: UIColor {
        get {
            return self.tBColor ?? .clear
        }
        
        set (value) {
            self.tBColor = value
        }
    }
    
    @objc public dynamic var aTintColor: UIColor {
        get {
            return self.tintColor
        }
        
        set (value) {
            self.tintColor = value
        }
    }
    
    @objc public dynamic var aShadow: T.Styles.Shadow? {
        get {
            guard let color = self.layer.shadowColor else {
                return nil
            }
            
            let shadow = T.Styles.Shadow()
            shadow.color = UIColor(cgColor: color)
            shadow.radius = self.layer.shadowRadius.float
            shadow.offset = self.layer.shadowOffset
            shadow.opacity = self.layer.opacity
            
            return shadow
        }
        
        set (value) {
            guard let value = value else {
                
                self.layer.shadowPath = nil
                self.layer.shadowOpacity = 0
                self.layer.shadowColor = nil
                self.layer.shadowOffset = .zero
                
                return
            }
            
            self.layer.shadowColor = value.color.cgColor
            self.layer.shadowOffset = value.offset
            self.layer.shadowOpacity = value.opacity
            self.layer.shadowRadius = value.radius.cgFloat
        }
    }
}
