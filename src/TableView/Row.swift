//
//  Row.swift
//  Pods-TDemo
//
//  Created by Virpik on 17/01/2018.
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
