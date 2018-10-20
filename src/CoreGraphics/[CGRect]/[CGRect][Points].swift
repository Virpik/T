//
//  [CGRect].swift
//  T
//
//  Created by Virpik on 13/02/2018.
//

import Foundation

/// For CGRect
public extension CGRect {
    
    public var max: CGPoint {
        return CGPoint(x: self.maxX, y: self.maxY)
    }
    
    public var min: CGPoint {
        return CGPoint(x: self.minX, y: self.minY)
    }
    
    public var mid: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    public func set(max: CGPoint) -> CGRect {
        var frame = self
        
        frame.origin = max
        
        return frame
    }
    
    public func set(min: CGPoint) -> CGRect {
        var frame = self
        
        frame.origin.x = min.x - frame.width
        frame.origin.y = min.y - frame.height
        
        return frame
    }
    
    public func set(mid: CGPoint) -> CGRect {
        var frame = self
        
        frame.origin.x = mid.x - (frame.width/2)
        frame.origin.y = mid.y - (frame.height/2)
        
        return frame
    }
}
