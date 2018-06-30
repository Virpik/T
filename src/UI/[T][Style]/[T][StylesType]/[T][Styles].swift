//
//  TStyle.swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

public typealias LabelStyle = T.Styles.Label
public typealias ViewStyle = T.Styles.View
public typealias ShadowStyle = T.Styles.Shadow

//public typealias UILabelStyle = (label: LabelStyle, view: ViewStyle)
//public typealias UIButtonStyle = (label: LabelStyle, view: ViewStyle)
//public typealias UITextFieldStyle = (label: LabelStyle, placeholder: LabelStyle, view: ViewStyle)

public extension T {
    public struct Styles { }
}

public struct UITextFieldStyle: Transformable, Configurable {
    
    public var label: LabelStyle
    public var placeholder: LabelStyle
    public var view: ViewStyle
    
    public init(_ label: LabelStyle, _ placeholder: LabelStyle, _ view: ViewStyle) {
        self.label = label
        self.view = view
        self.placeholder = placeholder
    }
}

public struct UILabelStyle: Transformable, Configurable {
    public var label: LabelStyle
    public var view: ViewStyle
    
    public init(_ label: LabelStyle, _ view: ViewStyle) {
        self.label = label
        self.view = view
    }
}

public struct UIButtonStyle: Transformable, Configurable {
    public var label: LabelStyle
    public var view: ViewStyle
    
    public init(_ label: LabelStyle, _ view: ViewStyle) {
        self.label = label
        self.view = view
    }
}
