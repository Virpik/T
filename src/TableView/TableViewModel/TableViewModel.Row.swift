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
        public var animation: UITableViewRowAnimation
        
        public init(model: AnyRowModel, indexPath: IndexPath, animation: UITableViewRowAnimation = .none) {
            self.rowModel = model
            self.indexPath = indexPath
            self.animation = animation
        }
    }
}
