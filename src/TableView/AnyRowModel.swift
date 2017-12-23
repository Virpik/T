//
//  AnyRowModel.swift
//  TDemo
//
//  Created by Virpik on 21/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

protocol AnyRowModel {
    var rowType: UITableViewCell.Type { get }
    
    var isMoving: Bool { get }
    var movingAnchorView: UIView? { get }
    
    func build(cell: UITableViewCell, indexPath: IndexPath)
    func didSelect(cell: UITableViewCell, indexPath: IndexPath)
}

extension AnyRowModel {
    var isMoving: Bool {
        return false
    }
    
    var movingAnchorView: UIView? {
        return nil
    }
}
