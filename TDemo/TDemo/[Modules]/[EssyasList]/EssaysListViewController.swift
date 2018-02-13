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
    
    private func _handlerDidMove(atContext: TableViewModel.CellContext, toContext: TableViewModel.CellContext) {
        self.essays.move(at: atContext.indexPath.row, to: toContext.indexPath.row)
    }
}
