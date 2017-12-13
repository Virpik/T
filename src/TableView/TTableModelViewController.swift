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
        
        self.tableViewModel = TableViewModel(tableView: self.tableView)
    }
    
    func load(rows: [[AnyRowModel]]) {
        rows.forEach {
            $0.forEach({ (rowModel) in
                self.tableView.register(type: rowModel.rowType.self)
            })
        }
        
        self.tableViewModel.sections = rows
        self.tableView.reloadData()
    }
}
