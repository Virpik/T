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

        public init(location: CGPoint, indexPath: IndexPath, rowModel: AnyRowModel, cell: UITableViewCell) {

            self.location = location
            self.originalIndexPath = indexPath
            self.indexPath = indexPath
            self.rowModel = rowModel
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

        public init(gesture: UILongPressGestureRecognizer, tableView: UITableView, getRowModel: ((IndexPath) -> AnyRowModel?)) {
            
            self.location = gesture.location(in: tableView)
    
            guard let indexPath = tableView.indexPathForRow(at: location) else {
                return
            }
            
            guard let cell = tableView.cellForRow(at: indexPath) else {
                return
            }
            
            guard let rowModel = getRowModel(indexPath) else {
                return
            }
            
            let cellContext = CellContext(location: location, indexPath: indexPath, rowModel: rowModel, cell: cell)
            self.cellMoveContext = cellContext

            var isAnchorView = false

            let view = rowModel.movingAnchorView ?? cell
            isAnchorView = view.bounds.contains(gesture.location(in: view))
            
            self.isMoving = (rowModel.isMoving) && isAnchorView
        }
    }
}

