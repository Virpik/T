//
//  TStyleSupportView.swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

protocol TStyleSupportView {
    
    var aBackgroundColor: UIColor { get set }
    
    var aAlpha: CGFloat { get set }
    
    var aBordeWidth: CGFloat { get set }
    
    var aCornerRadius: CGFloat { get set }
    
    var aBorderColor: UIColor { get set }
    
    var aTintColor: UIColor { get set }
    
    var aShadow: T.Styles.Shadow? { get set }
}

extension TStyleSupportView {
    
    @discardableResult
    public func apply (style: T.Styles.View) -> Self {
        var obj = self
        
        obj.aBackgroundColor = style.bgColor ?? .clear
        obj.aAlpha = style.alpha
        obj.aBordeWidth = style.bordeWidth.cgFloat
        obj.aCornerRadius = style.cornerRadius.cgFloat
        obj.aBorderColor = style.borderColor
        obj.aTintColor = style.tintColor ?? .clear
        obj.aShadow = style.shadow
        
        return self
    }
}

