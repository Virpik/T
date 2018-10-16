//
//  [IndexPath].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension IndexPath {
    
    /// Следующий элемент по текущей секции
    public func incRow() -> IndexPath {
        let section = self.section
        let row = self.row
        
        return IndexPath(row: row + 1, section: section)
    }
    
    /// Предыдущий элемент по текущей секции
    public func decRow() -> IndexPath {
        let section = self.section
        let row = self.row
        
        return IndexPath(row: row - 1, section: section)
    }
}
