//
//  [IndexPath].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension IndexPath {
    public func incRow() -> IndexPath {
        let section = self.section
        let row = self.row
        
        return IndexPath(row: row + 1, section: section)
    }
    
    public func decRow() -> IndexPath {
        let section = self.section
        let row = self.row
        
        return IndexPath(row: row - 1, section: section)
    }
}
