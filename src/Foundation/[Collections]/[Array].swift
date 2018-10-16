//
//  [Array][T].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension Array {
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    public func item(atIndex index: Int) -> Element? {
        return self[safe: index]
    }
    
    public func move(at: Int, to: Int) -> Array<Element> {
        var _self = self
        let item = _self[at]
        
        _self.remove(at: at)
        _self.insert(item, at: to)
        
        return _self
    }
}
