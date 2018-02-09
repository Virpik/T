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
        
        public var isMoving: Bool = false
        
        public var indexPath: IndexPath
        public private(set) var originalIndexPath: IndexPath

        public var rowModel: AnyRowModel
        public var cell: UITableViewCell

//        public private(set) var originSnapshot: UIView
//        public var snapshot: UIView

        public init(location: CGPoint, indexPath: IndexPath, rowModel: AnyRowModel, cell: UITableViewCell) {

            self.location = location
            self.originalIndexPath = indexPath
            self.indexPath = indexPath
            self.rowModel = rowModel
            self.cell = cell
            
//            self.originSnapshot = cell.snapshot()
//            self.snapshot = cell.snapshot()
    
            self = self.set(location: location)
        }
        
        public func set(location: CGPoint) -> CellContext {
            var context = self
            
            context.location = location

//            let _ = {
//                var centerPoint = context.originSnapshot.center
//                centerPoint.y = location.y
//                context.originSnapshot.center = centerPoint
//            }()
//
//            let _ = {
//                var centerPoint = context.snapshot.center
//                centerPoint.y = location.y
//                context.snapshot.center = centerPoint
//            }()
            
            return self
        }
    }
}

