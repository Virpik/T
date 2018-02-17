//
//  [CGRect].swift
//  T
//
//  Created by Virpik on 13/02/2018.
//

import Foundation

/// For CGRect
public extension CGRect.Extension {
    public var max: CGPoint {
        return CGPoint(x: self.origin.maxX, y: self.origin.maxY)
    }
    
    public var min: CGPoint {
        return CGPoint(x: self.origin.minX, y: self.origin.minY)
    }
    
    public var mid: CGPoint {
        return CGPoint(x: self.origin.midX, y: self.origin.midY)
    }
    
    public func set(max: CGPoint) -> CGRect {
        var frame = self.origin
        
        frame.origin = max
        
        return frame
    }
    
    public func set(min: CGPoint) -> CGRect {
        var frame = self.origin
        
        frame.origin.x = min.x - frame.width
        frame.origin.y = min.y - frame.height
        
        return frame
    }
    
    public func set(mid: CGPoint) -> CGRect {
        var frame = self.origin
        
        frame.origin.x = mid.x - (frame.width/2)
        frame.origin.y = mid.y - (frame.height/2)
        
        return frame
    }
}
