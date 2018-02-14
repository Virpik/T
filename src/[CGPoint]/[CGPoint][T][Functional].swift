//
//  [CGRect].swift
//  Pods-TDemo
//
//  Created by Virpik on 01/02/2018.
//

import Foundation

extension TExtension where Type == CGPoint {
    /// self.x = x
    func set(x: CGFloat) -> CGPoint {
        var point = self.origin
        
        point.x = x
        
        return point
    }
    
    /// self.y = y
    func set(y: CGFloat) -> CGPoint {
        var point = self.origin
        
        point.y = y
        
        return point
    }
    
    /// self.x += params.x
    func sum(x: CGFloat) -> CGPoint {
        var point = self.origin
        
        point.x += x
        
        return point
    }
    
    /// self.y += params.y
    func sum(y: CGFloat) -> CGPoint {
        var point = self.origin
        
        point.y += y
        
        return point
    }
}
