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

    public let tableView: UITableView

    public var sections: [[AnyRowModel]] = []

    public var movingContext: GestureContext?

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
        tLog(scrollView.contentOffset)
        
//        if let contentOffset = self.movingContext?.scrollViewContentOffset {
//            self.tableView.contentOffset = contentOffset
//        }

        self.handlers?.handlerDidScroll?(scrollView)
    }

    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tLog(scrollView.contentOffset)
    }

    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        tLog(scrollView.contentOffset)
    }

    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        tLog(scrollView.contentOffset, decelerate)
    }

    open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        tLog(scrollView.contentOffset)
    }

    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tLog(scrollView.contentOffset)
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

//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//
//    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        guard let gesture = gestureRecognizer as? UILongPressGestureRecognizer else {
            return false
        }

        let context = GestureContext(gesture: gesture, tableView: self.tableView, rows: self.sections)

        return context.isMoving && context.cellMoveContext != nil
    }

    @objc private func _gestureActions(gesture: UILongPressGestureRecognizer) {
        let state = gesture.state

        var context = GestureContext(gesture: gesture, tableView: self.tableView, rows: self.sections)
        context.scrollViewContentOffset = self.tableView.contentOffset
        
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
        
        self.movingContext = context

        let activeCContext = context.cellMoveContext!
        
//        self.tableView.addSubview(activeCContext.snapshot)
//        activeCContext.snapshot.isHidden = false
//        activeCContext.snapshot.alpha = 1
        
        self.handlers?.handletBeginMove?(activeCContext)
    }

    private func _move(context: GestureContext) {

        guard let atGContext = self.movingContext else {
            return
        }

        var atCContext = atGContext.cellMoveContext!

        var centerPoint = atCContext.snapshot.center
        centerPoint.y = context.location.y

        atCContext.snapshot.center = centerPoint
        atCContext.location = context.location

        self.movingContext?.cellMoveContext = atCContext

        self.handlers?.handlerMove?(atCContext, context.cellMoveContext?.indexPath)

        guard let toCContext = context.cellMoveContext else {
            return
        }

        // Не перемещаем ячейки если цель залочена
        if !toCContext.rowModel.isMoving {
            return
        }
        
        let atIndexPath = atCContext.indexPath
        let toIndexPath = toCContext.indexPath

        /// Перемещение
        // call handlers
        if atIndexPath != toIndexPath {
            
            let isDown = atIndexPath < toIndexPath
            self.movingContext?.cellMoveContext?.indexPath = toIndexPath
            
            let item = self.sections[atIndexPath.section][atIndexPath.row]
            
            self.sections[atIndexPath.section].remove(at: atIndexPath.row)
            self.sections[toIndexPath.section].insert(item, at: toIndexPath.row)
            
            /// Scroll begin
            self._checkScroll()
            //We simply cultural have fun
            
//            let isScroll: Bool = {
//                let controllCell = toCContext.cell
//
//                var tPoint = controllCell.frame.origin
//                tPoint.y -= self.tableView.contentOffset.y
//
//                var tFrame = controllCell.frame
//                tFrame.origin.y -= self.tableView.contentOffset.y
//
//                let isNotCellContains = !(self.tableView.frame.contains(tFrame))
//
//                if isNotCellContains {
//
//                    tLog(isDown ? "scroll down" : "scroll up")
//
//                    if isDown {
//                        self.tableView.scrollToRow(at: toIndexPath, at: .bottom, animated: true)
//                    } else {
//                        self.tableView.scrollToRow(at: toIndexPath, at: .top, animated: true)
//                    }
//
//                    return true
//                }
//
//                return false
//            }()
//
//            if isScroll {
//                return
//            }
            /// Scroll end

            
//            }

//
//            let deleteAnimation: UITableViewRowAnimation = isDown ? .top : .bottom
//            let insert: UITableViewRowAnimation = isDown ? .bottom : .top
//
//            self.tableView.beginUpdates()
//            self.tableView.deleteRows(at: [atIndexPath], with: deleteAnimation)
//            self.tableView.insertRows(at: [toIndexPath], with: insert)
//            self.tableView.endUpdates()
            self.tableView.moveRow(at: atIndexPath, to: toIndexPath)
            
//            atCContext.cell.isHidden = true
        }
    }
    
    private func _checkScroll() {
        guard let context = self.movingContext?.cellMoveContext else {
            return
        }
        
        let controllCell = context.cell
        
        var tPoint = controllCell.frame.origin
        tPoint.y -= self.tableView.contentOffset.y

        var tFrame = controllCell.frame
        tFrame.origin.y -= self.tableView.contentOffset.y

        let isNotCellContains = !(self.tableView.frame.contains(tFrame))

        if isNotCellContains {
        tLog("scroll")
//            tLog(isDown ? "scroll down" : "scroll up")
//
//            if isDown {
//                self.tableView.scrollToRow(at: toIndexPath, at: .bottom, animated: true)
//            } else {
//                self.tableView.scrollToRow(at: toIndexPath, at: .top, animated: true)
//            }
//
//            return true
        }
        
    }

    private func _beforeCell(at indexPath: IndexPath) -> UITableViewCell? {
        guard let indexPath = self._before(at: indexPath) else {
            return nil
        }
        
        return self.tableView.cellForRow(at: indexPath)
    }
    
    private func _previousCell(at indexPath: IndexPath) -> UITableViewCell? {
        guard let indexPath = self._previous(at: indexPath) else {
            return nil
        }
        
        return self.tableView.cellForRow(at: indexPath)
    }
    
    private func _before(at indexPath: IndexPath) -> IndexPath? {
        var section = indexPath.section
        var row = indexPath.row

        let sections = self.tableView.numberOfSections
        let rowsAtSection = self.tableView.numberOfRows(inSection: section)

        if rowsAtSection - 1 == row && sections - 1 == section {
            return nil
        }

        if rowsAtSection - 1 > row {
            row += 1

            return IndexPath(row: row, section: section)
        }

        if sections - 1 > section {
            section += 1
            row = 0

            return IndexPath(row: row, section: section)
        }

        return nil
    }

    private func _previous(at indexPath: IndexPath) -> IndexPath? {
        var section = indexPath.section
        var row = indexPath.row

        if row == 0 && section == 0 {
            return nil
        }

        if row > 0 {
            row -= 1

            return IndexPath(row: row, section: section)
        }

        if section > 0 {
            section -= 1
            row = self.tableView.numberOfRows(inSection: section) - 1
            return IndexPath(row: row, section: section)
        }

        return nil
    }

    private func _endMoving(context: GestureContext) {

        guard let activeGContext = self.movingContext else {
            return
        }

        let activeCContext = activeGContext.cellMoveContext!

        self.handlers?.handlerEndMove?(activeCContext, activeCContext.indexPath)
        
        activeCContext.cell.isHidden = false
//        activeCContext.cell.alpha = 0

        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                activeCContext.snapshot.center = activeCContext.cell.center
                activeCContext.snapshot.transform = CGAffineTransform.identity
            })
        }, completion: { _ in
//            activeCContext.snapshot.alpha = 0
//            activeCContext.cell.alpha = 1
            activeCContext.snapshot.removeFromSuperview()
            self.movingContext = nil
        })
    }
}
