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
        
        handlers.handlerDidMove = {_, _, atIndexPath, toIndexPath in
            self.items.move(at: atIndexPath.row, to: toIndexPath.row)
        }
        
        self.handlers = handlers
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupTable()
    }
    
    func setupTable() {
        let rows: [AnyRowModel] = self.items.map {
            return TDemoRowModel(item: $0)
        }
        
        self.set(rows: [rows])
    }
}
