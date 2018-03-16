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
    public var buttonStyle: ButtonStyle {
        
        let sLabel = self.aLabel.labelStyle
        let sView = self.aView.viewStyle
        
        return (sLabel, sView)
    }
    
    @discardableResult
    public func apply(_ style: ButtonStyle?) -> Self {
        guard let style = style else {
            return self
        }
        
        var _self = self
        
        _self.aView.apply(style.view)
        _self.aLabel.apply(style.label)
        
        return _self
    }
}
