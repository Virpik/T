//
//  TStyleSupportUILabel.swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension UILabel: TStyleSupportLabel {
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
    
    @objc public dynamic var aTextSize: Float {
        get {
            return self.font.pointSize.float
        }
        
        set (value) {
            self.font = self.font.withSize(value.cgFloat)
        }
    }
}