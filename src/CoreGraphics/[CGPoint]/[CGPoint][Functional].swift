//
//  [CGPoint].swift
//  Pods-TDemo
//
//  Created by Virpik on 01/02/2018.
//

import Foundation

/// For CGPoint
extension CGPoint {
    
    /// self.x = x
    public func set(x: CGFloat) -> CGPoint {
        var point = self
        
        point.x = x
        
        return point
    }
    
    /// self.y = y
    public func set(y: CGFloat) -> CGPoint {
        var point = self
        
        point.y = y
        
        return point
    }
    
    /// self.x += params.x
    public func sum(x: CGFloat) -> CGPoint {
        var point = self
        
        point.x += x
        
        return point
    }
    
    /// self.y += params.y
    public func sum(y: CGFloat) -> CGPoint {
        var point = self
        
        point.y += y
        
        return point
    }
}
