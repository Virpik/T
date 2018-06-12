//
//  TableViewRow.swift
//  T
//
//  Created by Virpik on 12/06/2018.
//

import Foundation

struct TableViewRow <Cell: UITableViewCell>: RowModelBlocks {
    
    typealias RowType = Cell
    
    var didSelect: ((Cell, IndexPath) -> Void)?
    var build: ((Cell, IndexPath) -> Void)?
    
    func build(cell: Cell, indexPath: IndexPath) {
        self.build?(cell, indexPath)
    }
    
    func didSelect(cell: Cell, indexPath: IndexPath) {
        self.didSelect?(cell, indexPath)
    }
}
