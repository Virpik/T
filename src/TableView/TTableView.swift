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

    // MARK: - scroll view
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.handlers?.handlerDidScroll?(scrollView)
    }

    // MARK: - Table view delegate && data sourse
    open func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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

        self.movingContext = context

        let activeCContext = context.cellMoveContext!

        self.handlers?.handletBeginMove?(activeCContext)
        // call handlers
//        self.handlers?.handlerWillMove?(activeCContext.rowModel, activeCContext.cell, activeCContext.indexPath)

        var centerPoint = activeCContext.cell.center
        activeCContext.snapshot.center = centerPoint
        activeCContext.snapshot.alpha = 0

        self.tableView.addSubview(activeCContext.snapshot)

        UIView.animate(withDuration: 0.3) {
            centerPoint.y = context.location.y
            activeCContext.snapshot.center = centerPoint
            activeCContext.snapshot.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            activeCContext.snapshot.alpha = 0.8
            activeCContext.cell.alpha = 0.0
        }
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

        let atIndexPath = atCContext.indexPath
        let toIndexPath = toCContext.indexPath

        /// Проверка на необходимость скрола
//        let visibleCells = self.tableView.visibleCells
//        let vIndexPaths = visibleCells.map { (cell) -> IndexPath in
//            return self.tableView.indexPath(for: cell)!
//        }
//
//        if let first = vIndexPaths.first, let firstCell = visibleCells.first, first == toIndexPath {
//            ####(context.location, firstCell.frame)
//        }

//        if let first = vIndexPaths.first, let firstCell = visibleCells.first, first == toIndexPath {
//            if let indexPath = self._previousIndexPath(at: first) {
////                let _ = self.tableView.cellForRow(at: indexPath)
//                ####("_previousIndexPath", first, indexPath)
////                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
////                return
//            }
//        }

//        if let last = vIndexPaths.last, last == toIndexPath {
//            if let indexPath = self._beforeIndexPath(at: last) {
////                let _ = self.tableView.cellForRow(at: indexPath)
//                ####("_beforeIndexPath", last, indexPath)
////                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
////                return
//            }
//        }

        /// Перемещение
        // call handlers

        if atIndexPath != toIndexPath {
            self.handlers?.handlerDidMove?(atCContext, toIndexPath)

            self.movingContext?.cellMoveContext?.indexPath = toIndexPath

            let item = self.sections[atIndexPath.section][atIndexPath.row]

            self.sections[atIndexPath.section].remove(at: atIndexPath.row)
            self.sections[toIndexPath.section].insert(item, at: toIndexPath.row)

            self.tableView.beginUpdates()

            self.tableView.moveRow(at: atIndexPath, to: toIndexPath)
            self.tableView.endUpdates()

            atCContext.cell.isHidden = true
        }
    }

    private func _beforeIndexPath(at indexPath: IndexPath) -> IndexPath? {
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

    private func _previousIndexPath(at indexPath: IndexPath) -> IndexPath? {
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
        // call handlers
//        self.handlers?.handlerDidMove?(activeCContext.rowModel,
//                                       activeCContext.cell,
//                                       activeCContext.originalIndexPath,
//                                       activeCContext.indexPath)

        activeCContext.cell.isHidden = false
        activeCContext.cell.alpha = 0

        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                activeCContext.snapshot.center = activeCContext.cell.center
                activeCContext.snapshot.transform = CGAffineTransform.identity
            })
        }, completion: { _ in
            activeCContext.snapshot.alpha = 0
            activeCContext.cell.alpha = 1
            activeCContext.snapshot.removeFromSuperview()
            self.movingContext = nil
        })
    }
}
//open class TableViewModel: NSObject, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
//
//    public let tableView: UITableView
//    public var sections: [[AnyRowModel]] = []
//    public var movingContext: GestureContext?
//    public var handlers: Handlers?
//
//    private var longPressGestue: UILongPressGestureRecognizer!
//
//    public var cellMoviesPressDuration: TimeInterval {
//        get {
//            return self.longPressGestue.minimumPressDuration
//        }
//
//        set(value) {
//            self.longPressGestue.minimumPressDuration = value
//        }
//    }
//
//    public init (tableView: UITableView, handlers: Handlers? = nil) {
//        self.tableView = tableView
//        self.handlers = handlers
//
//        super.init()
//
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//
//        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(_gestureActions))
//        gesture.minimumPressDuration = 0.01
//        gesture.delegate = self
//        self.tableView.addGestureRecognizer(gesture)
//
//        self.longPressGestue = gesture
//    }
//
//    public func remove(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .bottom) {
//
//        self.tableView.beginUpdates()
//
//        self.sections = sections
//
//        self.tableView.deleteRows(at: indexPaths, with: animation)
//
//        self.tableView.endUpdates()
//    }
//
//    public func update(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .automatic) {
//
//        self.tableView.beginUpdates()
//
//        self.sections = sections
//
//        self.tableView.reloadRows(at: indexPaths, with: animation)
//
//        self.tableView.endUpdates()
//    }
//
//    public func insert(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .bottom) {
//
//        self.tableView.beginUpdates()
//
//        self.sections = sections
//
//        self.tableView.insertRows(at: indexPaths, with: animation)
//
//        self.tableView.endUpdates()
//    }
//
//    // MARK: - Table view delegate && data sourse
//    public func numberOfSections(in tableView: UITableView) -> Int {
//        return self.sections.count
//    }
//
//    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.sections[section].count
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let model = self.sections[indexPath.section][indexPath.row]
//
//        guard let cell = self.tableView.cell(type: model.rowType) else {
//            return UITableViewCell()
//        }
//
//        model.build(cell: cell, indexPath: indexPath)
//
//        return cell
//    }
//
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = self.sections[indexPath.section][indexPath.row]
//
//        guard let cell = self.tableView.cellForRow(at: indexPath) else {
//            return
//        }
//
//        model.didSelect(cell: cell, indexPath: indexPath)
//    }
//
//    // MARK: Cell move
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//
//        guard let gesture = gestureRecognizer as? UILongPressGestureRecognizer else {
//            return false
//        }
//
//        let context = GestureContext(gesture: gesture, tableView: self.tableView, rows: self.sections)
//
//        return context.isMoving && context.cellMoveContext != nil
//    }
//
//    @objc private func _gestureActions(gesture: UILongPressGestureRecognizer) {
//        let state = gesture.state
//
//        let context = GestureContext(gesture: gesture, tableView: self.tableView, rows: self.sections)
//
//        switch state {
//        case .began:
//            self._beginMove(context: context)
//        case .changed:
//            self._move(context: context)
//        default:
//            self._endMoving(context: context)
//        }
//    }
//
//    private func _beginMove(context: GestureContext) {
//
//        tLog()
//
//        if context.isMoving != true || context.cellMoveContext == nil {
//            return
//        }
//
//
//        self.movingContext = context
//
//        let activeCContext = context.cellMoveContext!
//
//        // call handlers
//        self.handlers?.handlerWillMove?(activeCContext.rowModel, activeCContext.cell, activeCContext.indexPath)
//
//        var centerPoint = activeCContext.cell.center
//        activeCContext.snapshot.center = centerPoint
//        activeCContext.snapshot.alpha = 0
//
//        self.tableView.addSubview(activeCContext.snapshot)
//
//        UIView.animate(withDuration: 0.3) {
//            centerPoint.y = context.location.y;
//            activeCContext.snapshot.center = centerPoint;
//            activeCContext.snapshot.transform = CGAffineTransform(scaleX: 1.05, y: 1.05);
//            activeCContext.snapshot.alpha = 0.8;
//            activeCContext.cell.alpha = 0.0
//        }
//    }
//
//    private func _move(context: GestureContext) {
//        guard let atGContext = self.movingContext else {
//            return
//        }
//
//        guard let toCContext = context.cellMoveContext else {
//            return
//        }
//
//        let atCContext = atGContext.cellMoveContext!
//
//        let atIndexPath = atCContext.indexPath
//        let toIndexPath = toCContext.indexPath
//
//
//        /// Проверка на необходимость скрола
////        let visibleCells = self.tableView.visibleCells
////        let vIndexPaths = visibleCells.map { (cell) -> IndexPath in
////            return self.tableView.indexPath(for: cell)!
////        }
//
////        if let first = vIndexPaths.first, let firstCell = visibleCells.first, first == toIndexPath {
////            tLog(context.location, firstCell.frame)
////        }
//
////        if let first = vIndexPaths.first, let firstCell = visibleCells.first, first == toIndexPath {
////            if let indexPath = self._previousIndexPath(at: first) {
//////                let _ = self.tableView.cellForRow(at: indexPath)
////                tLog("_previousIndexPath", first, indexPath)
//////                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//////                return
////            }
////        }
//
////        if let last = vIndexPaths.last, last == toIndexPath {
////            if let indexPath = self._beforeIndexPath(at: last) {
//////                let _ = self.tableView.cellForRow(at: indexPath)
////                tLog("_beforeIndexPath", last, indexPath)
//////                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//////                return
////            }
////        }
//
//
//        /// Перемещение
//        // call handlers
//
//        var centerPoint = atCContext.snapshot.center
//        centerPoint.y = context.location.y
//        atCContext.snapshot.center = centerPoint;
//
//        if atIndexPath != toIndexPath {
//            self.handlers?.handlerMove?(atCContext.rowModel, atCContext.cell, atIndexPath, toIndexPath)
//            tLog(atIndexPath, toIndexPath)
//
//            self.movingContext?.cellMoveContext?.indexPath = toIndexPath
//
//            let item = self.sections[atIndexPath.section][atIndexPath.row]
//
//            self.sections[atIndexPath.section].remove(at: atIndexPath.row)
//            self.sections[toIndexPath.section].insert(item, at: toIndexPath.row)
//
//            self.tableView.beginUpdates()
//
//            self.tableView.moveRow(at: atIndexPath, to: toIndexPath)
//
//            self.tableView.endUpdates()
//
//            atCContext.cell.isHidden = true
//        }
//    }
//
//    private func _beforeIndexPath(at indexPath: IndexPath) -> IndexPath? {
//        var section = indexPath.section
//        var row = indexPath.row
//
//        let sections = self.tableView.numberOfSections
//        let rowsAtSection = self.tableView.numberOfRows(inSection: section)
//
//        if rowsAtSection - 1 == row && sections - 1 == section {
//            return nil
//        }
//
//        if rowsAtSection - 1 > row {
//            row += 1
//
//            return IndexPath(row: row, section: section)
//        }
//
//        if sections - 1 > section {
//            section += 1
//            row = 0
//
//            return IndexPath(row: row, section: section)
//        }
//
//        return nil
//    }
//
//    private func _previousIndexPath(at indexPath: IndexPath) -> IndexPath? {
//        var section = indexPath.section
//        var row = indexPath.row
//
//        if row == 0 && section == 0 {
//            return nil
//        }
//
//        if row > 0 {
//            row -= 1
//
//            return IndexPath(row: row, section: section)
//        }
//
//        if section > 0 {
//            section -= 1
//            row = self.tableView.numberOfRows(inSection: section) - 1
//            return IndexPath(row: row, section: section)
//        }
//
//        return nil
//    }
//
//    private func _endMoving(context: GestureContext) {
//        tLog()
//
//        guard let activeGContext = self.movingContext else {
//            return
//        }
//
//        let activeCContext = activeGContext.cellMoveContext!
//
//        // call handlers
//
//        self.handlers?.handlerDidMove?(activeCContext.rowModel,
//                                       activeCContext.cell,
//                                       activeCContext.originalIndexPath,
//                                       activeCContext.indexPath)
//
//        activeCContext.cell.isHidden = false
//        activeCContext.cell.alpha = 0
//
//        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .calculationModeLinear, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
//                activeCContext.snapshot.center = activeCContext.cell.center
//                activeCContext.snapshot.transform = CGAffineTransform.identity
//            })
//        }, completion: { _ in
//            activeCContext.snapshot.alpha = 0
//            activeCContext.cell.alpha = 1
//            activeCContext.snapshot.removeFromSuperview()
//            self.movingContext = nil
//        })
//    }
//}
//
