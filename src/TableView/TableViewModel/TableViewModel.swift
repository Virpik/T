//
//  TImage.swift
//  TDemo
//
//  Created by Virpik on 26/10/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

open class TableViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    public let tableView: UITableView

    public var sections: [[AnyRowModel]] = []

//    public var moveHandlers: MoveHandlers? {
//        set(handlers) {
//            self._managerMoveCells.handlers = handlers
//        }
//
//        get {
//            return self._managerMoveCells.handlers
//        }
//    }
//
    public var handlers: Handlers?

    public var cellMoviesPressDuration: TimeInterval {
        get {
            return self._managerMoveCells.cellMoviesPressDuration
        }
        
        set(value) {
            self._managerMoveCells.cellMoviesPressDuration = value
        }
    }

    private lazy var _managerMoveCells: ManagerMoveCells = {
        let ds = TableViewModel.ManagerMoveCells.DataSourse { (indexPath) -> AnyRowModel? in
            return self.sections[indexPath.section][indexPath.row]
        }
        
        return ManagerMoveCells(tableView: tableView, dataSourse: ds)
    }()
    
    private var _cashHeightRows: [IndexPath: CGSize] = [:]
    
    public init (tableView: UITableView, handlers: Handlers? = nil) {
        self.tableView = tableView
        self.handlers = handlers
        
        super.init()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        var mHandlers = MoveHandlers()
        
        mHandlers.handlerBeginMove = { context in
            //
            self.handlers?.moveHandlers?.handlerBeginMove?(context)
        }
        
        mHandlers.handlerMove = { atContext, toContext in
            //
            self.handlers?.moveHandlers?.handlerMove?(atContext, toContext)
        }
        
        mHandlers.handlerDidMove = { atContex, toContext in

            let atIndexPath = atContex.indexPath
            let toIndexPath = toContext.indexPath
            
            let item = self.sections[atIndexPath.section][atIndexPath.row]

            self.sections[atIndexPath.section].remove(at: atIndexPath.row)
            self.sections[toIndexPath.section].insert(item, at: toIndexPath.row)
            
            self.handlers?.moveHandlers?.handlerDidMove?(atContex, toContext)
        }
        
        mHandlers.handlerEndMove = { atContext, toContext in
            //
            self.handlers?.moveHandlers?.handlerEndMove?(atContext, toContext)
        }
        
        self._managerMoveCells.handlers = mHandlers
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
}
