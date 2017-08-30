//
//  TTableView.swift
//  TDemo
//
//  Created by Virpik on 29/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

protocol AnyRowModel {
    var rowType: UITableViewCell.Type { get }
    
    func build(cell: UITableViewCell, indexPath: IndexPath)
    func didSelect(cell: UITableViewCell, indexPath: IndexPath)
}

protocol RowModel: AnyRowModel {
    associatedtype RowType: UITableViewCell
    
    func build(cell: RowType, indexPath: IndexPath)
    func didSelect(cell: RowType, indexPath: IndexPath)
}

extension RowModel {
    var rowType: UITableViewCell.Type {
        return RowType.self
    }
    
    func build(cell: UITableViewCell, indexPath: IndexPath) {
        guard let cell = cell as? RowType else {
            assertionFailure("Wrong usage")
            return
        }
        
        self.build(cell: cell, indexPath: indexPath)
    }
    
    func didSelect(cell: UITableViewCell, indexPath: IndexPath) {
        guard let cell = cell as? RowType else {
            assertionFailure("Wrong usage")
            return
        }
        
        self.didSelect(cell: cell, indexPath: indexPath)
    }
}

class TableViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView
    
    var sections: [[AnyRowModel]] = []
    
    init (tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - Table view delegate && data sourse
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.sections[indexPath.section][indexPath.row]
        
        guard let cell = self.tableView.cell(type: model.rowType) else {
            return UITableViewCell()
        }
        
        model.build(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.sections[indexPath.section][indexPath.row]
        
        guard let cell = self.tableView.cellForRow(at: indexPath) else {
            return
        }
        
        model.didSelect(cell: cell, indexPath: indexPath)
    }
}
