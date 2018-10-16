//
//  [Array][T].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension Array {
    
    /// Фикс выхода за пределы массива
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    /// Аналог фиккса выхода за пределы массива, только без '[]'
    public func item(atIndex index: Int) -> Element? {
        return self[safe: index]
    }
    
    /// Переме элемента массива at индекса to индекс
    public func move(at: Int, to: Int) -> Array<Element> {
        var _self = self
        let item = _self[at]
        
        _self.remove(at: at)
        _self.insert(item, at: to)
        
        return _self
    }
}
