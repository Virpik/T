//
//  ViewController.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import UIKit

class ViewController: TTableModelViewController {

    private var menuItem: [TMenuItem] = []
    
    private var demoTableViewController: TDemoTableViewController = TDemoTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "[Examples & Tests]"
        
        self.menuItem = [
            TMenuItem(title: "TTableView", block: self._tableViewDemo)
        ]
        
        self.setup()
    }

    func setup() {
        self.tableView.setupAutomaticDimension()
        
        let rowModels: [AnyRowModel] = self.menuItem.map({
            return TMenuItemRowModel(menuItem: $0)
        })
        
        self.set(rows: [rowModels])
    }
    
    func _tableViewDemo() {
        self.show(self.demoTableViewController, sender: self)
    }
}

