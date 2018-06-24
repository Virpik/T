//
//  TableViewModel.GestureContext.swift
//  T
//
//  Created by Virpik on 08/02/2018.
//

import Foundation

extension TableViewModel {
    public struct GestureContext {

        public var location: CGPoint
        
        public var cellContext: CellContext?
        
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
            
            let locationFromCell = gesture.location(in: cell)
            
            var cellContext = CellContext(location: location, locationFromCell: locationFromCell, indexPath: indexPath, rowModel: rowModel, cell: cell)
            
            var isAnchorView = false
            
            let view = rowModel.movingAnchorView ?? cell
            isAnchorView = view.bounds.contains(gesture.location(in: view))
            
            cellContext.isMoving = (rowModel.isMoving) && isAnchorView
            
            self.cellContext = cellContext
        }
    }
}
