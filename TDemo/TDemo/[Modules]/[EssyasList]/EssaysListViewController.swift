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
    
    private var tableHeaderView: UIView = {
        let view = UIView(width: 100, height: 100)
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
        
        mHanlders.handlerDidMove = { atContext, toContext in
            self.essays.move(at: atContext.indexPath.row, to: toContext.indexPath.row)
        }
        
        _handlers.moveHandlers = mHanlders
        
        self.handlers = _handlers
        
        self.setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableHeaderView.frame.size.width = self.tableView.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func setupTable() {
        func getModel(at item: TDemoItem) -> TDemoRowModel {
            var model = TDemoRowModel(item: item)
            
            return model
        }
        
        let rows: [AnyRowModel] = self.items.map {
            
            let model = getModel(at: $0)
            
            return model
        }
        
        self.set(rows: [rows])
    }
    
    private func indexPath(at item: TDemoItem) -> IndexPath? {
        return self.items.index(of: item).map({
            IndexPath(row: $0, section: 0)
        })
    }
}
