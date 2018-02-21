//
//  [Array][T][Ext].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension Array.Ext {
    public func item(atIndex index: Int) -> Element? {
        if self.origin.count <= index {
            return nil
        }
        
        if index < 0 {
            return nil
        }
        
        return self.origin[index]
    }
    
    public func move(at: Int, to: Int) -> Array<Element> {
        var _self = self.origin
        let item = _self[at]
        
        _self.remove(at: at)
        _self.insert(item, at: to)
        
        return _self
    }
}
