//
//  TStyleSupportView.swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

protocol TStyleSupportLabel {

    var aTextColor: UIColor { get set }
    
    var aTextFont: UIFont { get set }
    
    var aTextSize: Float { get set }
}

extension TStyleSupportLabel {
    
    public var labelStyle: T.Styles.Label {
        var style = T.Styles.Label()
        
        style.textColor = self.aTextColor
        style.textSize = self.aTextSize
        style.textFont = self.aTextFont
        
        return style
    }
    
    @discardableResult
    public func apply (style: T.Styles.Label) -> Self {
        var obj = self
        
        obj.aTextFont = style.textFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        obj.aTextSize = style.textSize ?? UIFont.systemFontSize.float
        obj.aTextColor = style.textColor ?? .black
        
        return obj
    }
}
