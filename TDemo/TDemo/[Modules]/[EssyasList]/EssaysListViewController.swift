//
//  TDemoTableViewController.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit
import T

class EssaysListViewController: TTableModelViewController {
    typealias CellContext = TableViewModel.CellContext
//    private var activeEssayView: EssayView {
//        return self.tableHeaderView.essayView
//    }
    
    private var tableHeaderView: UIView  = {
        let view = UIView(width: 320, height: 200)
        view.backgroundColor = .red
        return view
    }()
    
    private var essays: [Essay] = []
    
    private var _snapshot: UIView?
    
    private var _cover: UIView = {
        let cover = UIView(width: 100, height: 100)
        
        let blurEffect = UIBlurEffect(style: .light)

        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.backgroundColor = UIColor.red.t.transparency(0.1)
        blurView.alpha = 0.99
        blurView.frame = cover.bounds
        
        cover.ext_view.tAddSubview(view: blurView)
        
        return cover
    }()
    
    private var _isOutOfCellLimits: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = Data(fileName: "essays") {
            self.essays = (try? JSONDecoder().decode(Essays.self, from: data))?.essays ?? []
        }
        
        self.tableView.tableHeaderView = self.tableHeaderView
        self.tableView.ext_view.tAddSubview(view: self._cover)
        
        self._cover.alpha = 0
        self._cover.isHidden = false
        
        var _handlers = TableHandlers()
        var mHanlders = TableMoveCellHandlers()
        
        mHanlders.handlerDidMove =  self._handlerDidMove
        mHanlders.handlerMove = self._handlerMove(atContext:toConttext:)
        mHanlders.handlerEndMove = self._handlerEndMove(atContext:toContext:)
        
        _handlers.moveHandlers = mHanlders
        
        /// Устанавливаем handlers у TTableModelViewController
        self.handlers = _handlers
        
        self.setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        self.tableHeaderView.frame.size.height = 200
        self.tableHeaderView.frame.size.width = self.tableView.bounds.width
        
        var coverFrame = self.tableView.frame
        coverFrame.size.height -= self.tableHeaderView.bounds.height
        coverFrame.origin = self.tableHeaderView.frame.t.max
        coverFrame.origin.x = 0
        self._cover.frame = coverFrame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupTable() {
        func getModel(at item: Essay) -> EssaysCartRowModel {
            var model = EssaysCartRowModel(item: item)
            model.didSelect = self._didSelect
            return model
        }
        
        let rows: [AnyRowModel] = self.essays.map {
            let model = getModel(at: $0)
            return model
        }
        
        self.set(rows: [rows])
    }
    
    private func _didSelect(cell: EssayCardCell, indexPath: IndexPath) {
        tLog(indexPath)
    }
    
    private func _handlerMove(atContext: CellContext, toConttext: CellContext?) {
        self._checkOutCellLimits(context: atContext)
    }
    
    private func _handlerDidMove(atContext: CellContext, toContext: CellContext) {
        self.essays = self.essays.t.move(at: atContext.indexPath.row, to: toContext.indexPath.row)
    }
    
    private func _handlerEndMove(atContext: CellContext, toContext: CellContext?) {
        if self._isOutOfCellLimits {
            self._uninstallOutOfCellLimitsState(context: atContext)
            self._isOutOfCellLimits = false
        }
    }
    
    // MARK: - Check out of cell limits
    private func _checkOutCellLimits(context: CellContext) {
        let frame = context.hypotheticalFrame
        
        let isContains = self.tableHeaderView.frame.intersects(frame)//contains(context.location)
        
        if (context.indexPath != IndexPath(row: 0, section: 0) || !isContains) && self._isOutOfCellLimits {
            self._uninstallOutOfCellLimitsState(context: context)
            self._isOutOfCellLimits = false
            return
        }
        
        if context.indexPath == IndexPath(row: 0, section: 0) && isContains {
            if self._isOutOfCellLimits {
                self._updateOutOfCellLimitsState(context: context)
            } else {
                self._setupOutOfCellLimitsState(context: context)
                self._isOutOfCellLimits = true
            }
        }
    }
    
    private func _setupOutOfCellLimitsState(context: CellContext) {
        self.tableView.bringSubview(toFront: self._cover)
        
        self._cover.ext_view.show(duration: 0.2)
        
        let snapshot = self._setupSnashot(context: context)
        self._moveSnaphot(snapshot: snapshot, context: context)
        self._snapshot = snapshot
    }
    
    private func _uninstallOutOfCellLimitsState(context: CellContext) {
        self._cover.ext_view.hidde(duration: 0.2)

        if let snapshot = self._snapshot {
            self._uninstallSnapshot(snapshot: snapshot, context: context)
            self._snapshot = nil
        }
    }
    
    private func _updateOutOfCellLimitsState(context: CellContext) {
        
        if let snapshot = self._snapshot {
            self.tableView.bringSubview(toFront: self._cover)
            self.tableView.bringSubview(toFront: snapshot)
            
            self._moveSnaphot(snapshot: snapshot, context: context)
        }
    }

    private func _setupSnashot(context: CellContext) -> UIView {
        let image = context.cell.ext_view.render()
        
        let imageView = UIImageView(frame: context.cell.bounds)
        
        imageView.image = image
        
        self.tableView.addSubview(imageView)
        
        return imageView
    }
    
    private func _moveSnaphot(snapshot: UIView, context: CellContext) {
        snapshot.frame = context.hypotheticalFrame
    }
    
    private func _uninstallSnapshot(snapshot: UIView, context: CellContext) {
        snapshot.ext_view.hidde(duration: 0.2) {
            snapshot.removeFromSuperview()
        }
    }
}
