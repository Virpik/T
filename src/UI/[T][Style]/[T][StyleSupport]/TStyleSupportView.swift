//
//  TStyleSupportView.swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

public protocol TStyleSupportView {
    
    var aBackgroundColor: UIColor { get set }
    
    var aAlpha: CGFloat { get set }
    
    var aBordeWidth: CGFloat { get set }
    
    var aCornerRadius: CGFloat { get set }
    
    var aBorderColor: UIColor { get set }
    
    var aTintColor: UIColor { get set }
    
    var aShadow: T.Styles.Shadow? { get set }
}

extension TStyleSupportView {
    
    public var viewStyle: T.Styles.View {
        var style = T.Styles.View()
        
        style.bgColor = self.aBackgroundColor
        style.alpha = self.aAlpha
        style.bordeWidth = self.aBordeWidth.float
        style.cornerRadius = self.aCornerRadius.float
        style.borderColor = self.aBorderColor
        style.tintColor = self.aTintColor
        style.shadow = self.aShadow
        
        return style
    }
    
    @discardableResult
    public func apply(_ style: T.Styles.View?) -> Self {
        guard let style = style else {
            return self
        }
        
        var obj = self
        
        obj.aBackgroundColor = style.bgColor ?? .clear
        obj.aAlpha = style.alpha
        obj.aBordeWidth = style.bordeWidth.cgFloat
        obj.aCornerRadius = style.cornerRadius.cgFloat
        obj.aBorderColor = style.borderColor
        obj.aTintColor = style.tintColor ?? .clear
        obj.aShadow = style.shadow
        
        return obj
    }
}

