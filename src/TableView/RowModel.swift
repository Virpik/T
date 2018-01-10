//
//  RowModel.swift
//  TDemo
//
//  Created by Virpik on 21/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

public protocol RowModel: AnyRowModel {
    associatedtype RowType: UITableViewCell
    
    func build(cell: RowType, indexPath: IndexPath)
    func didSelect(cell: RowType, indexPath: IndexPath)
}

public extension RowModel {
    public var rowType: UITableViewCell.Type {
        return RowType.self
    }
    
    public func build(cell: UITableViewCell, indexPath: IndexPath) {
        guard let cell = cell as? RowType else {
            assertionFailure("Wrong usage")
            return
        }
        
        self.build(cell: cell, indexPath: indexPath)
    }
    
    public func didSelect(cell: UITableViewCell, indexPath: IndexPath) {
        guard let cell = cell as? RowType else {
            assertionFailure("Wrong usage")
            return
        }
        
        self.didSelect(cell: cell, indexPath: indexPath)
    }
    
    public func didSelect(cell: RowType, indexPath: IndexPath) {
        
    }
}
