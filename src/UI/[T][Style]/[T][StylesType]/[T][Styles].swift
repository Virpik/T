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

public typealias UILabelStyle = (label: LabelStyle, view: ViewStyle)
public typealias UIButtonStyle = (label: LabelStyle, view: ViewStyle)
public typealias UITextFieldStyle = (label: LabelStyle, placeholder: LabelStyle, view: ViewStyle)

public extension T {
    public struct Styles { }
}
