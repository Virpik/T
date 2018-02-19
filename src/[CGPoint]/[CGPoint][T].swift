//
//  [CGPoint].swift
//  T
//
//  Created by Virpik on 13/02/2018.
//

import Foundation

extension CGPoint {
    public typealias TypeObject = CGPoint
    
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
}
