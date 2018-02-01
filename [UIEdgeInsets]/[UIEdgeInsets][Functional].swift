//
//  File.swift
//  T
//
//  Created by Virpik on 01/02/2018.
//

import Foundation

public extension UIEdgeInsets {
    public func set(top: CGFloat) -> UIEdgeInsets {
        var edgeInsets = self
        edgeInsets.top = top
        return edgeInsets
    }
    
    public func set(bottom: CGFloat) -> UIEdgeInsets {
        var edgeInsets = self
        edgeInsets.bottom = bottom
        return edgeInsets
    }
    
    public func set(left: CGFloat) -> UIEdgeInsets {
        var edgeInsets = self
        edgeInsets.left = left
        return edgeInsets
    }
    
    public func set(right: CGFloat) -> UIEdgeInsets {
        var edgeInsets = self
        edgeInsets.right = right
        return edgeInsets
    }
}
