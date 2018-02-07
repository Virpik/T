//
//  TImage.swift
//  TDemo
//
//  Created by Virpik on 26/10/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

open class TableViewModel: NSObject, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    private enum _TypeScroll {
        case up
        case down
    }
    
    public let tableView: UITableView

    public var sections: [[AnyRowModel]] = []

    /// Контекс перемещаемой ячейки, задается при событии began, Gesture
    public var atContext: GestureContext?
    /// Контекст, захваченый при событии change, Gesture, необходим для определения текущей локации
    public var toContext: GestureContext?

    public var handlers: Handlers?

    private var longPressGestue: UILongPressGestureRecognizer!

    public var cellMoviesPressDuration: TimeInterval {
        get {
            return self.longPressGestue.minimumPressDuration
        }

        set(value) {
            self.longPressGestue.minimumPressDuration = value
        }
    }

    private var _cashHeightRows: [IndexPath: CGSize] = [:]
    
    public init (tableView: UITableView, handlers: Handlers? = nil) {
        self.tableView = tableView
        self.handlers = handlers

        super.init()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(_gestureActions))
        gesture.minimumPressDuration = 0.01
        gesture.delegate = self
        self.tableView.addGestureRecognizer(gesture)

        self.longPressGestue = gesture
    }

    public func reload(rows: [Row]) {
        rows.forEach { (row) in
            self.sections[row.indexPath.section][row.indexPath.row] = row.rowModel
            if let cell = self.tableView.cellForRow(at: row.indexPath) {
                row.rowModel.build(cell: cell, indexPath: row.indexPath)
            }
        }
    }
    
    public func remove(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .bottom) {

        self.tableView.beginUpdates()

        self.sections = sections

        self.tableView.deleteRows(at: indexPaths, with: animation)

        self.tableView.endUpdates()
    }

    public func update(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .automatic) {

        self.tableView.beginUpdates()

        self.sections = sections

        self.tableView.reloadRows(at: indexPaths, with: animation)

        self.tableView.endUpdates()
    }

    public func insert(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .bottom) {

        self.tableView.beginUpdates()

        self.sections = sections

        self.tableView.insertRows(at: indexPaths, with: animation)

        self.tableView.endUpdates()
    }
    
    public func insert(rows: [Row]) {
        self.tableView.beginUpdates()
        
        rows.forEach { row in
            self.sections[row.indexPath.section].insert(row.rowModel, at: row.indexPath.row)
            self.tableView.insertRows(at: [row.indexPath], with: row.animation)
        }
        
        self.tableView.endUpdates()
    }
    
    public func replace(rows: [Row]) {
        self.tableView.beginUpdates()
        
        rows.forEach { row in
            self.sections[row.indexPath.section][row.indexPath.row] = row.rowModel
            self.tableView.reloadRows(at: [row.indexPath], with: row.animation)
        }
        
        self.tableView.endUpdates()
    }
    
    public func remove(rows: [(IndexPath, UITableViewRowAnimation)]) {
        self.tableView.beginUpdates()
        rows.forEach { row in
            self.sections[row.0.section].remove(at: row.0.row)
            self.tableView.deleteRows(at: [row.0], with: row.1)
        }
        self.tableView.endUpdates()
    }

    // MARK: - scroll view
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        tLog(scrollView.contentOffset)
    
        self.handlers?.handlerDidScroll?(scrollView)
    }
    
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        tLog(scrollView.contentOffset)
    }
    
    // MARK: - Table view delegate && data sourse
    open func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.sections[indexPath.section][indexPath.row].rowHeight ?? tableView.rowHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self._cashHeightRows[indexPath]?.height ?? tableView.estimatedRowHeight
    }

    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self._cashHeightRows[indexPath] = cell.bounds.size
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = self.sections[indexPath.section][indexPath.row]

        guard let cell = self.tableView.cell(type: model.rowType) else {
            return UITableViewCell()
        }

        model.build(cell: cell, indexPath: indexPath)

        return cell
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.sections[indexPath.section][indexPath.row]

        guard let cell = self.tableView.cellForRow(at: indexPath) else {
            return
        }

        model.didSelect(cell: cell, indexPath: indexPath)
    }

    // MARK: Cell move
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        guard let gesture = gestureRecognizer as? UILongPressGestureRecognizer else {
            return false
        }

        let context = GestureContext(gesture: gesture, tableView: self.tableView, rows: self.sections)

        return context.isMoving && context.cellMoveContext != nil
    }

    @objc private func _gestureActions(gesture: UILongPressGestureRecognizer) {
        let state = gesture.state

        let context = GestureContext(gesture: gesture, tableView: self.tableView, rows: self.sections)
        
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

        if context.isMoving != true || context.cellMoveContext == nil {
            return
        }
        
        tLog(tag: "[DEV]", "[BEGIN MOVE]", context.cellMoveContext?.indexPath)
        
        self.atContext = context

        let activeCContext = context.cellMoveContext!
       
        /// Устанавливаем снапшот
        self._setupSnapshot(context: activeCContext)
        
        self.handlers?.handletBeginMove?(activeCContext)
    }
    
    private var _isScrolling = false
    
    private func _move(context: GestureContext) {
        
        if self._isScrolling {
            return
        }
        
        guard let atGContext = self.atContext else {
            return
        }
        
        let toGContext = context
        
        self.toContext = toGContext
        
        /// Задаем новую локацию у контекста перемещаемой ячейки
        let atCContext = atGContext.cellMoveContext!.set(location: toGContext.location)
        self.atContext?.cellMoveContext = atCContext
        
        /// Перемещенеи снапшота
        self._locateSnapshot(context: atCContext)
        
        self.handlers?.handlerMove?(atCContext, toGContext.cellMoveContext?.indexPath)

        /// Если текущий контекст перемещения не содержит ячейки - выходим
        guard let toCContext = toGContext.cellMoveContext else {
            return
        }

        /// Не перемещаем ячейки если цель залочена
        if !toCContext.rowModel.isMoving {
            return
        }
        
        let atIndexPath = atCContext.indexPath
        let toIndexPath = toCContext.indexPath

        self._Scroll() {

            if atIndexPath != toIndexPath {
                
                let isDown = atIndexPath < toIndexPath
                let isUp = !isDown

                let atCellFrame = atCContext.originSnapshot.frame
                let toCellFrame = toCContext.cell.frame

                let atCellMidMaxPoint = CGPoint(x: atCellFrame.midX, y: atCellFrame.maxY)
                let atCellMidMinPoint = CGPoint(x: atCellFrame.midX, y: atCellFrame.minY)
                
                if isDown {
                    let isTrue = !toCellFrame.contains(atCellMidMaxPoint) && toCellFrame.contains(atCellMidMinPoint)

                    if !isTrue {
                        return
                    }
                }

                if isUp {
                    let isTrue = !toCellFrame.contains(atCellMidMinPoint) && toCellFrame.contains(atCellMidMaxPoint)
                    if !isTrue {
                        return
                    }
                }
                
                self.atContext?.cellMoveContext?.indexPath = toIndexPath
                
                let item = self.sections[atIndexPath.section][atIndexPath.row]
                
                self.sections[atIndexPath.section].remove(at: atIndexPath.row)
                self.sections[toIndexPath.section].insert(item, at: toIndexPath.row)
                
                self.tableView.moveRow(at: atIndexPath, to: toIndexPath)
            }

        }

    }
    
    private func _endMoving(context: GestureContext) {
        
        guard let activeGContext = self.atContext else {
            return
        }
        
        self.atContext = nil
        self.toContext = nil
        
        let activeCContext = activeGContext.cellMoveContext!
        
        /// Удаляем снапшот
        self._uninstallSnapshot(context: activeCContext)
        
        self.handlers?.handlerEndMove?(activeCContext, activeCContext.indexPath)
        
        activeCContext.cell.isHidden = false
        
//        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .calculationModeLinear, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
//                activeCContext.snapshot.center = activeCContext.cell.center
//                activeCContext.snapshot.transform = CGAffineTransform.identity
//            })
//        }, completion: { _ in
//            activeCContext.snapshot.removeFromSuperview()
//            self.atContext = nil
//        })
    }
    
    /// Return (up or down scroll + offset scroll) or nil
    @discardableResult private func _Scroll(handler: Block?) -> (_TypeScroll, CGFloat)? {
        guard let atGContext = self.atContext else {
            handler?()
            return nil
        }
        
        guard let context = atGContext.cellMoveContext else {
            handler?()
            return nil
        }
    
        let snaphotFrame = context.originSnapshot.frame
        
        let tableViewFrame = self.tableView.bounds
        let location = context.location
        
        let minPoint = location.set(y: snaphotFrame.minY)
        let maxPoint = location.set(y: snaphotFrame.maxY)

        let cellAbove: UITableViewCell? = {
            guard let indexPath = self.tableView.indexPathForRow(at: minPoint) else {
                handler?()
                return nil
            }

            return self.tableView.cellForRow(at: indexPath)
        }()
        
        let cellBelow: UITableViewCell? = {
            guard let indexPath = self.tableView.indexPathForRow(at: maxPoint) else {
                handler?()
                return nil
            }
            
            return self.tableView.cellForRow(at: indexPath)
        }()

        let frameCellAbove = cellAbove?.frame ?? snaphotFrame
        let frameCellBelow = cellBelow?.frame ?? snaphotFrame
        
        let upLocation = location.set(y: frameCellAbove.minY)
        let downLocation = location.set(y: frameCellBelow.maxY)
        
        var scrollType: _TypeScroll?
        var offset: CGFloat = 0
        
        if !tableViewFrame.contains(upLocation) {
            scrollType = .up
            offset = max(upLocation.y, 0) - tableViewFrame.minY
        }

        if !tableViewFrame.contains(downLocation) {
            scrollType = .down
            offset = min(downLocation.y, self.tableView.contentSize.height) - tableViewFrame.maxY
        }
        
        guard let _scrollType = scrollType else {
            handler?()
            return nil
        }

        let contentOffset = self.tableView.contentOffset.sum(y: offset)
        
        self._isScrolling = true
        
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView.contentOffset = contentOffset
        }, completion: { success in
            self._isScrolling = false
            handler?()
        })
        
        return (_scrollType, offset)
    }
    
    private func _setupSnapshot(context: CellContext) {
//        context.snapshot.alpha = 1
//        self.tableView.addSubview(context.snapshot)
//        self._locateSnapshot(context: context)
    }
    
    private func _locateSnapshot(context: CellContext) {
//        context.snapshot.center = context.originSnapshot.center
    }
    
    private func _uninstallSnapshot(context: CellContext) {
//        context.snapshot.alpha = 0
//        context.snapshot.removeFromSuperview()
    }
}
