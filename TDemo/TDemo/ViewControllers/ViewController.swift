//
//  ViewController.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import UIKit
import T

class ViewController: TTableModelViewController {

    private var menuItem: [TMenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "[Examples & Tests]"
        
        self.menuItem = [
            TMenuItem(title: "TTableView [Essays]", block: self._essaysList),
            TMenuItem(title: "TStyles", block: self._tSlyles)
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
    
    func _tSlyles() {
        let vc = TStylesViewController()
        
        self.show(vc, sender: self)
    }
    
    func _essaysList() {
        let vc = EssaysListViewController()
        
        self.show(vc, sender: self)
    }
}

