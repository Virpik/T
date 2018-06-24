//
//  [NSNumber].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension NSNumber {
    public var float: Float {
        return self.floatValue
    }
    
    public var cgFloat: CGFloat {
        return self.floatValue.cgFloat
    }
    
    public var int: Int {
        return self.intValue
    }
    
    public var double: Double {
        return self.doubleValue
    }
    
    public var string: String {
        return "\(self)"
    }
}
