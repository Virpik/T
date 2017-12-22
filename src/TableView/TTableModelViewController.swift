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
    
    @IBOutlet private(set) weak var tableView: UITableView!
    private(set) var tableViewModel: TableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.tableView == nil {
            self._installTableView()
        }
        
        self.tableViewModel = TableViewModel(tableView: self.tableView)
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
