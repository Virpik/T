//
//  TableViewModel.ManagerMoveCells.swift
//  T
//
//  Created by Virpik on 02/02/2018.
//

import Foundation

extension TableViewModel {
    class ManagerMoveCells: NSObject, UIGestureRecognizerDelegate {
        
        struct DataSourse {
            var getRowModel: ((IndexPath) -> AnyRowModel?)
        }
        
        private enum _TypeScroll {
            case up
            case down
        }
        
        public var handlers: MoveHandlers?
        
        /// Контекс перемещаемой ячейки, задается при событии began, Gesture
        public var atContext: GestureContext?
        /// Контекст, захваченый при событии change, Gesture, необходим для определения текущей локации
        public var toContext: GestureContext?

        private var longPressGestue: UILongPressGestureRecognizer!
        
        public var cellMoviesPressDuration: TimeInterval {
            get {
                return self.longPressGestue.minimumPressDuration
            }
            
            set(value) {
                self.longPressGestue.minimumPressDuration = value
            }
        }
        
        private var tableView: UITableView
        private var dataSourse: DataSourse
        
        private var _activeGContext: GestureContext?
        private var _activeCContext: CellContext? {
            return self._activeGContext?.cellContext
        }
        
        init(tableView: UITableView, dataSourse: DataSourse) {
            self.tableView = tableView
            self.dataSourse = dataSourse
           
            super.init()
            
            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self._gestureActions))
            gesture.minimumPressDuration = 0.01
            gesture.delegate = self
            
            self.tableView.addGestureRecognizer(gesture)
            self.longPressGestue = gesture
        }
        
        public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            
            guard let gesture = gestureRecognizer as? UILongPressGestureRecognizer else {
                return false
            }
            
            let context = GestureContext(gesture: gesture, tableView: self.tableView, getRowModel: self.dataSourse.getRowModel)
            
            guard let cellContext = context.cellContext else {
                return false
            }
            
            return cellContext.isMoving
        }
        
        @objc private func _gestureActions(gesture: UILongPressGestureRecognizer) {
            let state = gesture.state
            let getRowModelBlock = self.dataSourse.getRowModel
            let context = GestureContext(gesture: gesture, tableView: self.tableView, getRowModel: getRowModelBlock)
            
            switch state {
                case .began:
                    self._beginMove(context: context)
                case .changed:
                    self._move(context: context)
                default:
                    self._endMoving(context: context)
            }
        }
        
        private func _beginMove(context: GestureContext) {
            guard let cContext = context.cellContext else {
                return
            }
            
            if !cContext.isMoving {
                return
            }
            
            self._activeGContext = context
            
            self.handlers?.handlerBeginMove?(cContext)
        }
        
        private func _move(context: GestureContext) {
            
            guard let atGContext = self._activeGContext else {
                return
            }
        
            guard let atCContext = atGContext.cellContext else {
                return
            }

            /// Обновляем location перемещаемого контекста на текущий
            self._activeGContext?.cellContext?.location = context.location
            
            /// call handlerMove
            self.handlers?.handlerMove?(atCContext, context.cellContext)
            
            let toGContext = context
            
            guard let toCContet = toGContext.cellContext else {
                return
            }
            
            let atIndexPath = atCContext.indexPath
            let toIndexPath = toCContet.indexPath
            
            if atIndexPath != toIndexPath {
                
                /// Обновляем indexPath контекста, перемещаемой ячейки
                self._activeGContext?.cellContext?.indexPath = toCContet.indexPath
                
                self.handlers?.handlerDidMove?(atCContext, toCContet)
                
                self.tableView.moveRow(at: atIndexPath, to: toIndexPath)
            }
            
        }
        
        private func _endMoving(context: GestureContext) {
            guard let activeContext = self._activeCContext else {
                return
            }
            
            self.handlers?.handlerEndMove?( activeContext, context.cellContext)
            
            self._activeGContext = nil
        }
    }
}
