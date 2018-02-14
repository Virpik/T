//
//  TExtensionable.swift
//  Pods-TDemo
//
//  Created by Virpik on 13/02/2018.
//

import Foundation

public protocol TExtensionable {
    var t: TExtension<Self> { get }
    static var t: TExtension<Self.Type> { get }
}

public extension TExtensionable {
    public var t: TExtension<Self> {
        return TExtension<Self>(origin: self)
    }
    
    public static var t: TExtension<Self.Type> {
        return TExtension<Self.Type>(origin: self)
    }
}
