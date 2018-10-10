//
//  [T][Styles][Label].swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension T.Styles {
    public struct Label: Configurable, Transformable {
        public var textColor: UIColor?
        
        public var textFont: UIFont?
        public var textAligment: NSTextAlignment = .left
//        public var textSize: Float?
        
        public init() { }
    }
}

public extension T.Styles.Label {
    
    public func with(textColor: UIColor?) -> T.Styles.Label {
        var _self = self
        
        _self.textColor = textColor
        
        return _self
    }
    
    public func with(textFont: UIFont?) -> T.Styles.Label {
        var _self = self
        
        _self.textFont = textFont
        
        return _self
    }
    
    public func with(textAligment: NSTextAlignment) -> T.Styles.Label {
        var _self = self
        
        _self.textAligment = textAligment
        
        return _self
    }
}
