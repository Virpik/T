//
//  TImage.swift
//  TDemo
//
//  Created by Virpik on 26/10/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

extension TableViewModel {
    struct Handlers {
        typealias DefaultBlock = ((AnyRowModel, UITableViewCell, IndexPath) -> Void)
        
        // debug
        var handler: Block?
        
        var handlerDidSelect: DefaultBlock?
        var handlerDidDeselect: DefaultBlock?
        
        var handlerWillMove: DefaultBlock?
        var handlerMove: ((AnyRowModel, UITableViewCell, _ at: IndexPath, _ to:IndexPath) -> Void)?
        var handlerDidMove: ((AnyRowModel, UITableViewCell, _ at: IndexPath, _ to:IndexPath) -> Void)?
    }
}

class TableViewModel: NSObject, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    let tableView: UITableView
    
    var sections: [[AnyRowModel]] = []
    
    var movingContext: GestureContext?
    
    var handlers: Handlers?
    
    private var longPressGestue: UILongPressGestureRecognizer!
    
    var cellMoviesPressDuration: TimeInterval {
        get {
            return self.longPressGestue.minimumPressDuration
        }
        
        set(value) {
            self.longPressGestue.minimumPressDuration = value
        }
    }
    
    init (tableView: UITableView, handlers: Handlers? = nil) {
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
    
    func remove(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .bottom) {
        
        self.tableView.beginUpdates()
        
        self.sections = sections
        
        self.tableView.deleteRows(at: indexPaths, with: animation)
        
        self.tableView.endUpdates()
    }
    
    func update(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .automatic) {
        
        self.tableView.beginUpdates()
        
        self.sections = sections
        
        self.tableView.reloadRows(at: indexPaths, with: animation)
        
        self.tableView.endUpdates()
    }
    
    func insert(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .bottom) {
        
        self.tableView.beginUpdates()
        
        self.sections = sections
        
        self.tableView.insertRows(at: indexPaths, with: animation)
        
        self.tableView.endUpdates()
    }
    
    // MARK: - Table view delegate && data sourse
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = self.sections[indexPath.section][indexPath.row]
        
        guard let cell = self.tableView.cell(type: model.rowType) else {
            return UITableViewCell()
        }
        
        model.build(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        
        tLog()
        
        if context.isMoving != true || context.cellMoveContext == nil {
            return
        }
        
        
        self.movingContext = context
        
        let activeCContext = context.cellMoveContext!
        
        // call handlers
        self.handlers?.handlerWillMove?(activeCContext.rowModel, activeCContext.cell, activeCContext.indexPath)
        
        var centerPoint = activeCContext.cell.center
        activeCContext.snapshot.center = centerPoint
        activeCContext.snapshot.alpha = 0
        
        self.tableView.addSubview(activeCContext.snapshot)
        
        UIView.animate(withDuration: 0.3) {
            centerPoint.y = context.location.y;
            activeCContext.snapshot.center = centerPoint;
            activeCContext.snapshot.transform = CGAffineTransform(scaleX: 1.05, y: 1.05);
            activeCContext.snapshot.alpha = 0.8;
            activeCContext.cell.alpha = 0.0
        }
    }
    
    private func _move(context: GestureContext) {
        guard let atGContext = self.movingContext else {
            return
        }
        
        guard let toCContext = context.cellMoveContext else {
            return
        }
        
        let atCContext = atGContext.cellMoveContext!
        
        let atIndexPath = atCContext.indexPath
        let toIndexPath = toCContext.indexPath
        
        // call handlers
        self.handlers?.handlerMove?(atCContext.rowModel, atCContext.cell, atIndexPath, toIndexPath)
        tLog(atIndexPath, toIndexPath)
        
        var centerPoint = atCContext.snapshot.center
        centerPoint.y = context.location.y
        atCContext.snapshot.center = centerPoint;
        
        if atIndexPath != toIndexPath {
            self.movingContext?.cellMoveContext?.indexPath = toIndexPath
            
            let item = self.sections[atIndexPath.section][atIndexPath.row]
            
            self.sections[atIndexPath.section].remove(at: atIndexPath.row)
            self.sections[toIndexPath.section].insert(item, at: toIndexPath.row)
            
            self.tableView.moveRow(at: atIndexPath, to: toIndexPath)
            atCContext.cell.isHidden = true
        }
    }
    
    private func _endMoving(context: GestureContext) {
        tLog()
        
        guard let activeGContext = self.movingContext else {
            return
        }
        
        let activeCContext = activeGContext.cellMoveContext!
        
        // call handlers
        self.handlers?.handlerDidMove?(activeCContext.rowModel, activeCContext.cell, activeCContext.originalIndexPath, activeCContext.indexPath)
        
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

