//
//  TableViewModel.Handlers.swift
//  TDemo
//
//  Created by Virpik on 29/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

public extension TableViewModel {
    public struct Handlers {
        public typealias DefaultBlock = ((AnyRowModel, UITableViewCell, IndexPath) -> Void)
        // debug
        public var handler: Block?
        
        public var handlerDidSelect: DefaultBlock?
        public var handlerDidDeselect: DefaultBlock?
        
        public var handlerWillMove: DefaultBlock?
        public var handlerMove: ((AnyRowModel, UITableViewCell, _ at: IndexPath, _ to:IndexPath) -> Void)?
        public var handlerDidMove: ((AnyRowModel, UITableViewCell, _ at: IndexPath, _ to:IndexPath) -> Void)?
        
        public init() {
            
        }
    }
}
