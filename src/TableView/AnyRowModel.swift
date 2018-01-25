//
//  AnyRowModel.swift
//  TDemo
//
//  Created by Virpik on 21/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

public protocol AnyRowModel {
    var rowType: UITableViewCell.Type { get }
    
    var isMoving: Bool { get }
    var movingAnchorView: UIView? { get }
    
    var rowHeight: CGFloat? { get } // default: tableView.rowHeigh
    
    func build(cell: UITableViewCell, indexPath: IndexPath)
    func didSelect(cell: UITableViewCell, indexPath: IndexPath)
}

public extension AnyRowModel {
    public var rowHeight: CGFloat? {
        return nil
    }
    
    public var isMoving: Bool {
        return false
    }
    
    public var movingAnchorView: UIView? {
        return nil
    }
}
