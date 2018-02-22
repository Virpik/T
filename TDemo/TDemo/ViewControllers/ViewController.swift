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
    
    private var essaysListViewController = EssaysListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "[Examples & Tests]"
        
        self.menuItem = [
            TMenuItem(title: "TTableView [Essays]", block: self._essaysList),
            TMenuItem(title: "FlowArhitech", block: self._flowArhitech)
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
    
    func _essaysList() {
        self.show(self.essaysListViewController, sender: self)
    }
    
    func _flowArhitech() {
        let appFlow = SimulatioAppFlow()
        self.show(appFlow.viewController, sender: self)
    }
}
