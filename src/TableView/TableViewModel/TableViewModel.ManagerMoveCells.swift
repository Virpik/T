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
            
            return context.isMoving && context.cellMoveContext != nil
        }
        
        @objc private func _gestureActions(gesture: UILongPressGestureRecognizer) {
            let state = gesture.state
            
            let context = GestureContext(gesture: gesture, tableView: self.tableView, getRowModel: self.dataSourse.getRowModel)
            
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
            
        }
        
        private func _move(context: GestureContext) {
            
        }
        
        private func _endMoving(context: GestureContext) {
            
        }
    }
}
