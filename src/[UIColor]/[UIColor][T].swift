//
//  [UIColor][T].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension UIColor {
    public typealias TypeObject = UIColor
    
    public struct Ext {
        public var origin: TypeObject
    }
    
    public struct ExtStatic {
        public var origin: TypeObject.Type
    }
    
    public struct ExtDebug {
        public var origin: TypeObject
    }
    
    public struct ExtDebugStatic {
        public var origin: TypeObject.Type
    }
    
    public var t: Ext {
        return Ext(origin: self)
    }
    
    public static var t: ExtStatic {
        return ExtStatic(origin: self)
    }
    
    public var debug: ExtDebug {
        return ExtDebug(origin: self)
    }
    
    public static var debug: ExtDebugStatic {
        return ExtDebugStatic(origin: self)
    }
}
