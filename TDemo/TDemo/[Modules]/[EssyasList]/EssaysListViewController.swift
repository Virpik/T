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
        let view = UIView(width: 320, height: 100)
        view.backgroundColor = .red
        return view
    }()
    
    private var essays: [Essay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = Data(fileName: "essays") {
            self.essays = (try? JSONDecoder().decode(Essays.self, from: data))?.essays ?? []
        }
        
        self.tableView.tableHeaderView = self.tableHeaderView
        
        var _handlers = TableHandlers()
        var mHanlders = TableMoveCellHandlers()
        
        mHanlders.handlerDidMove =  self._handlerDidMove
        mHanlders.handlerMove = self._handlerMove(atContext:toConttext:)
        
        _handlers.moveHandlers = mHanlders
        
        /// Устанавливаем handlers у TTableModelViewController
        self.handlers = _handlers
        
        self.setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        self.tableHeaderView.frame.size.height = 200
        self.tableHeaderView.frame.size.width = self.tableView.bounds.width
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
        self._snapshotControll(context: atContext)
    }
    
    private func _handlerDidMove(atContext: CellContext, toContext: CellContext) {
        self.essays.move(at: atContext.indexPath.row, to: toContext.indexPath.row)
    }
    
    // MARK: - Check snaphot
    private var _snapshot: UIView?
    
    private func _snapshotControll(context: CellContext) {
        let frame = context.hypotheticalFrame
        
        let isContains = self.tableHeaderView.frame.intersects(frame)//contains(context.location)
        
        if context.indexPath != IndexPath(row: 0, section: 0) || !isContains {

            if let snapshot = self._snapshot {
                self._uninstallSnapshot(snapshot: snapshot, context: context)
                self._snapshot = nil
            }
            
            return
        }

        if context.indexPath == IndexPath(row: 0, section: 0) && isContains {
            if let snapshot = self._snapshot {
                self._moveSnaphot(snapshot: snapshot, context: context)
            } else {
                let snapshot = self._setupSnashot(context: context)
                
                self._moveSnaphot(snapshot: snapshot, context: context)
                
                self._snapshot = snapshot
            }
        }
    }
    
    private func _setupSnashot(context: CellContext) -> UIView {
        let image = context.cell.render()
        
        let imageView = UIImageView(frame: context.cell.bounds)
        
        imageView.image = image
        
        self.tableView.addSubview(imageView)
        
        return imageView
    }
    
    private func _moveSnaphot(snapshot: UIView, context: CellContext) {
        let sFrame = snapshot.frame
        snapshot.center = context.location
        snapshot.frame.origin.x = sFrame.minX
    }
    
    private func _uninstallSnapshot(snapshot: UIView, context: CellContext) {
        snapshot.removeFromSuperview()
    }
}
