//
//  TTableModelViewController.swift
//  TDemo
//
//  Created by Virpik on 13/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

class TTableModelViewController: UIViewController {
    
    typealias TableHandlers = TableViewModel.Handlers
    
    @IBOutlet private(set) weak var tableView: UITableView!
    private(set) var tableViewModel: TableViewModel!
    
    var handlers: TableHandlers? {
        didSet(value) {
            self.tableViewModel.handlers = self.handlers
        }
    }
    
    var cellMoviesPressDuration: TimeInterval {
        get {
            return self.tableViewModel.cellMoviesPressDuration
        }
        
        set(value) {
            self.tableViewModel.cellMoviesPressDuration = value
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.tableView == nil {
            self._installTableView()
        }
        
        self.tableViewModel = TableViewModel(tableView: self.tableView, handlers: self.handlers)
    }
    
    func set(rows: [[AnyRowModel]]) {
        rows.forEach {
            $0.forEach({ (rowModel) in
                self.tableView.register(type: rowModel.rowType.self)
            })
        }
        
        self.tableViewModel.sections = rows
        self.tableView.reloadData()
    }
    
    private func _installTableView() {
        let tableView = UITableView(frame: self.view.bounds)
        self.tableView = tableView
        tableView.separatorStyle = .none
        
        self.view.tAddSubview(view: tableView)
    }
}

