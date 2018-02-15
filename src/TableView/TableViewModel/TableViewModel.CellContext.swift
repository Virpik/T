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
        // tableView
        public var location: CGPoint
        public var locationFromCell: CGPoint
        
        // cell.frame + location
        public var hypotheticalFrame: CGRect {
            let cellFrame = self.cell.frame
            
            let tY: CGFloat = self.locationFromCell.y - (cellFrame.height / 2)
            
            var frame = cellFrame.t.set(mid: location)
            frame.origin.y -= tY
            frame.origin.x = cellFrame.origin.x
            
            return frame
        }
        
        public var isMoving: Bool = false
        
        public var indexPath: IndexPath
        public private(set) var originalIndexPath: IndexPath

        public var rowModel: AnyRowModel
        public var cell: UITableViewCell

        public init(location: CGPoint, locationFromCell: CGPoint, indexPath: IndexPath, rowModel: AnyRowModel, cell: UITableViewCell) {

            self.location = location
            self.locationFromCell = locationFromCell
            self.originalIndexPath = indexPath
            self.indexPath = indexPath
            self.rowModel = rowModel
            self.cell = cell
            
            self = self.set(location: location)
        }
        
        public func set(location: CGPoint) -> CellContext {
            var context = self
            
            context.location = location
            
            return self
        }
    }
}

