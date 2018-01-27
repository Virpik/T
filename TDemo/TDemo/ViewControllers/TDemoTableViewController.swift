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

class TDemoTableViewController: TTableModelViewController {
    
    private var items: [TDemoItem] = {
        return [
            TDemoItem(title: "Title1", color: UIColor.red.transparency(0.3)),
            TDemoItem(title: "Title2", color: UIColor.green.transparency(0.3)),
            TDemoItem(title: "Title3", color: UIColor.blue.transparency(0.3)),
            TDemoItem(title: "Title4", color: UIColor.purple.transparency(0.3)),
            TDemoItem(title: "Title5", color: UIColor.orange.transparency(0.3)),
            TDemoItem(title: "Title6", color: UIColor.cyan.transparency(0.3)),
            TDemoItem(title: "Title7", color: UIColor.red.transparency(0.3)),
            TDemoItem(title: "Title8", color: UIColor.green.transparency(0.3)),
            TDemoItem(title: "Title9", color: UIColor.blue.transparency(0.3)),
            TDemoItem(title: "Title10", color: UIColor.purple.transparency(0.3)),
            TDemoItem(title: "Title11", color: UIColor.orange.transparency(0.3)),
            TDemoItem(title: "Title12", color: UIColor.cyan.transparency(0.3))
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tLog()
        
        var handlers = TableHandlers()
        
        handlers.handlerDidMove = {context, toIndexPath in
            self.items.move(at: context.indexPath.row, to: toIndexPath.row)
        }
        
        self.handlers = handlers
        
        self.setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func setupTable() {
        func getModel(at item: TDemoItem) -> TDemoRowModel {
            var model = TDemoRowModel(item: item)
            
            model.blockAddToBottom = { item in
                guard let indexPath = self.indexPath(at: item)?.incRow() else {
                    return
                }
                
                let newItem = TDemoItem(title: "Title at \(item.title ?? "#NULL#")", color: UIColor.random().transparency(0.3))
                self.items.insert(newItem, at: indexPath.row)
                let rowModel = getModel(at: newItem)
                let row = TableViewModel.Row(model: rowModel, indexPath: indexPath, animation: .top)
                self.tableViewModel.insert(rows: [row])
            }
            
            model.blockDelete = { item in
                guard let indexPath = self.indexPath(at: item) else {
                    return
                }

                self.items.remove(at: indexPath.row)
                self.tableViewModel.remove(rows: [(indexPath, .bottom)])
            }
            
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
