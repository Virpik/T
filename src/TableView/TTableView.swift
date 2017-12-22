//
//  TImage.swift
//  TDemo
//
//  Created by Virpik on 26/10/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

class TableViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView
    
    var sections: [[AnyRowModel]] = []
    
    init (tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func remove(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .bottom) {
        
        self.tableView.beginUpdates()
        
        self.sections = sections
        
        self.tableView.deleteRows(at: indexPaths, with: animation)
        
        self.tableView.endUpdates()
    }
    
    func update(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .automatic) {
        
        self.tableView.beginUpdates()
        
        self.sections = sections
        
        self.tableView.reloadRows(at: indexPaths, with: animation)
        
        self.tableView.endUpdates()
    }
    
    func insert(sections: [[AnyRowModel]], indexPaths: [IndexPath], animation: UITableViewRowAnimation = .bottom) {
        
        self.tableView.beginUpdates()
        
        self.sections = sections
        
        self.tableView.insertRows(at: indexPaths, with: animation)
        
        self.tableView.endUpdates()
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
    
    //    override func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    //        return false
    //    }
}

