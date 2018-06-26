//
//  TStyleSupportButton.swift
//  PinLayout
//
//  Created by Virpik on 16/03/2018.
//

import Foundation

public protocol TStyleSupportButton {
    var aLabel: TStyleSupportLabel { get }
    var aView: TStyleSupportView { get }
}

public extension TStyleSupportButton {
    public var uiButtonStyle: UIButtonStyle {
        
        let sLabel = self.aLabel.labelStyle
        let sView = self.aView.viewStyle
        
        return UIButtonStyle(sLabel, sView)
    }
    
    @discardableResult
    public func apply(_ style: UIButtonStyle?) -> Self {
        guard let style = style else {
            return self
        }
        
        let _self = self
        
        _self.aView.apply(style.view)
        _self.aLabel.apply(style.label)
        
        return _self
    }
}
