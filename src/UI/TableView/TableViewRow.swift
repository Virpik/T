//
//  TableViewRow.swift
//  T
//
//  Created by Virpik on 12/06/2018.
//

import Foundation

public struct TableViewRow <Cell: UITableViewCell>: RowModelBlocks {
    
    public typealias RowType = Cell
    
    public var didSelect: ((Cell, IndexPath) -> Void)?
    public var build: ((Cell, IndexPath) -> Void)?
    
    public var isNib: Bool = false
    
    public init() {
        
    }
    
    public func build(cell: Cell, indexPath: IndexPath) {
        self.build?(cell, indexPath)
    }
    
    public func didSelect(cell: Cell, indexPath: IndexPath) {
        self.didSelect?(cell, indexPath)
    }
}
