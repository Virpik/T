//
//  TableViewModel.MoveContext.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

extension TableViewModel {
    struct CellMoveContext {
        var indexPath: IndexPath
        private(set) var originalIndexPath: IndexPath
        
        var rowModel: AnyRowModel
        var cell: UITableViewCell
        
        var snapshot: UIView
        
        init?(location: CGPoint, tableView: UITableView, rows: [[AnyRowModel]]) {
            guard let indexPath = tableView.indexPathForRow(at: location) else {
                return nil
            }
            
            guard let cell = tableView.cellForRow(at: indexPath) else {
                return nil
            }
            
            self.originalIndexPath = indexPath
            self.indexPath = indexPath
            self.rowModel = rows[indexPath.section][indexPath.row]
            self.cell = cell
            self.snapshot = cell.snapshot()
        }
    }
    
    struct GestureContext {
        
        var location: CGPoint
        var isMoving: Bool = false
        
        var cellMoveContext: CellMoveContext?
        
        init(gesture: UILongPressGestureRecognizer, tableView: UITableView, rows: [[AnyRowModel]]) {
            self.location = gesture.location(in: tableView)
            self.cellMoveContext = CellMoveContext(location: location, tableView: tableView, rows: rows)
            
            var isAnchorView = false
            
            if let cellMoveContext = self.cellMoveContext {
                let view = cellMoveContext.rowModel.movingAnchorView ?? cellMoveContext.cell
                isAnchorView = view.bounds.contains(gesture.location(in: view))
            }
            
            let rowModel = self.cellMoveContext?.rowModel
            self.isMoving = (rowModel?.isMoving ?? false) && isAnchorView
        }
    }
}
