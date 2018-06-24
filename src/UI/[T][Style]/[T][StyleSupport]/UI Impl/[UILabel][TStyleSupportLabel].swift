//
//  TStyleSupportUILabel.swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension UILabel: TStyleSupportLabel {
    public var uiLabelStyle: UILabelStyle {
        return (self.labelStyle, self.viewStyle)
    }
    
    public func apply(_ style: UILabelStyle?) {
        guard let style = style else {
            return
        }
        
        self.apply(style.view)
        self.apply(style.label)
    }
    
    @objc public dynamic var aTextColor: UIColor {
        get {
            return self.textColor
        }
        
        set (value) {
            self.textColor = value
        }
    }
    
    @objc public dynamic var aTextFont: UIFont {
        get {
            return self.font
        }
        
        set (value) {
            self.font = value
        }
    }
    
    @objc public dynamic var aTextAlignment: NSTextAlignment {
        get {
            return self.textAlignment
        }
        
        set (value) {
            self.textAlignment = value
        }
    }
    
    @objc public dynamic var aTextSize: Float {
        get {
            return self.font.pointSize.float
        }
        
        set (value) {
            self.font = self.font.withSize(value.cgFloat)
        }
    }
}
