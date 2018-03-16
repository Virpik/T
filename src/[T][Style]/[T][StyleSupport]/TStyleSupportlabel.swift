//
//  TStyleSupportView.swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

public protocol TStyleSupportLabel {

    var aTextColor: UIColor { get set }
    
    var aTextFont: UIFont { get set }
    
    var aTextAlignment: NSTextAlignment { get set }
//    var aTextSize: Float { get set }
}

extension TStyleSupportLabel {
    
    public var labelStyle: T.Styles.Label {
        var style = T.Styles.Label()
        
        style.textColor = self.aTextColor
        style.textFont = self.aTextFont
        style.textAligment = self.aTextAlignment
        
        return style
    }
    
    @discardableResult
    public func apply(_ style: T.Styles.Label?) -> Self {
        guard let style = style else {
            return self
        }
        
        var obj = self
        
        obj.aTextAlignment = style.textAligment
        obj.aTextFont = style.textFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        obj.aTextColor = style.textColor ?? .black
        
        return obj
    }
}
