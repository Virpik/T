//
//  [CGRect].swift
//  Pods-TDemo
//
//  Created by Virpik on 13/02/2018.
//

import Foundation

extension CGRect {
    public typealias TypeObject = CGRect
    
    public struct Ext {
        public var origin: TypeObject
    }
    
    public struct ExtStatic {
        public var origin: TypeObject.Type
    }
    
    public var t: Ext {
        return Ext(origin: self)
    }
    
    public static var t: ExtStatic {
        return ExtStatic(origin: self)
    }
    
    public init(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        self.init(x: x, y: y, width: w, height: h)
    }
}
