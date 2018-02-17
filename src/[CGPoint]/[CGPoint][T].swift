//
//  [CGPoint].swift
//  T
//
//  Created by Virpik on 13/02/2018.
//

import Foundation

extension CGPoint {
    public typealias TypeObject = CGPoint
    
    public struct Extension {
        public var origin: TypeObject
    }
    
    public struct ExtensionStatic {
        public var origin: TypeObject.Type
    }
    
    var t: Extension {
        return Extension(origin: self)
    }
    
    static var t: ExtensionStatic {
        return ExtensionStatic(origin: self)
    }
}
