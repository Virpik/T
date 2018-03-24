//
//  TStyleSupportTextField.swift
//  PinLayout
//
//  Created by Virpik on 16/03/2018.
//

import Foundation

public protocol TStyleSupportTextField {
    var aLabel: TStyleSupportLabel { get }
    var aPlaceholder: TStyleSupportLabel { get }
    var aView: TStyleSupportView { get }
}

public extension TStyleSupportTextField {
    
    public var UITextFieldStyle: UITextFieldStyle {
        
        let sPlaceholder = self.aPlaceholder.labelStyle
        let sLabel = self.aLabel.labelStyle
        let sView = self.aView.viewStyle
        
        return (sLabel, sPlaceholder, sView)
    }
    
    @discardableResult
    public func apply(_ style: UITextFieldStyle?) -> Self {
        guard let style = style else {
            return self
        }
        
        let _self = self
        
        _self.aPlaceholder.apply(style.placeholder)
        _self.aView.apply(style.view)
        _self.aLabel.apply(style.label)
        
        return _self
    }
}
