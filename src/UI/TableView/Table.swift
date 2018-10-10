//
//  Table.swift
//  T
//
//  Created by Virpik on 25/06/2018.
//

import Foundation

public struct Table<T: UITableView> {
    
    public var view: T
    public var viewModel: TableViewModel
    
    public init() {
        self.view = T.defaultScreen()
        self.viewModel = TableViewModel(tableView: self.view)
        
        self.view.separatorStyle = .none
        self.view.setupAutomaticDimension()
    }
}
