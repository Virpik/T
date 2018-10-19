//
//  TableViewModel.Row.swift
//  T
//
//  Created by Virpik on 12/06/2018.
//

import Foundation

public extension TableViewModel {
    
    public struct Row {
        
        public var indexPath: IndexPath
        public var rowModel: AnyRowModel
        public var animation: UITableView.RowAnimation
        
        public init(model: AnyRowModel, indexPath: IndexPath, animation: UITableView.RowAnimation = .none) {
            self.rowModel = model
            self.indexPath = indexPath
            self.animation = animation
        }
    }
}
