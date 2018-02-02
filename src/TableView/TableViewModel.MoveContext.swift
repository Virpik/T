//
//  TableViewModel.MoveContext.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

public extension TableViewModel {
    public struct CellContext {
        public var location: CGPoint
        
        public var indexPath: IndexPath
        public private(set) var originalIndexPath: IndexPath

        public var rowModel: AnyRowModel
        public var cell: UITableViewCell

        public private(set) var originSnapshot: UIView
        public var snapshot: UIView

        public init?(location: CGPoint, tableView: UITableView, rows: [[AnyRowModel]]) {
            guard let indexPath = tableView.indexPathForRow(at: location) else {
                return nil
            }

            guard let cell = tableView.cellForRow(at: indexPath) else {
                return nil
            }

            self.location = location
            self.originalIndexPath = indexPath
            self.indexPath = indexPath
            self.rowModel = rows[indexPath.section][indexPath.row]
            self.cell = cell
            
            self.originSnapshot = cell.snapshot()
            self.snapshot = cell.snapshot()
        }
        
        public func set(location: CGPoint) -> CellContext {
            var context = self
            
            context.location = location

            let _ = {
                var centerPoint = context.originSnapshot.center
                centerPoint.y = location.y
                context.originSnapshot.center = centerPoint
            }()
            
            let _ = {
                var centerPoint = context.snapshot.center
                centerPoint.y = location.y
                context.snapshot.center = centerPoint
            }()
            
            return self
        }
    }

    public struct GestureContext {
        
        public var location: CGPoint
        public var isMoving: Bool = false

        public var cellMoveContext: CellContext?

        public init(gesture: UILongPressGestureRecognizer, tableView: UITableView, rows: [[AnyRowModel]]) {
            self.gesture = gesture
            self.tableView = tableView
            self.rows = rows
            
            self.location = gesture.location(in: tableView)
            self.cellMoveContext = CellContext(location: location, tableView: tableView, rows: rows)

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

