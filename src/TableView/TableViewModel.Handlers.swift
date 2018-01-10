//
//  TableViewModel.Handlers.swift
//  TDemo
//
//  Created by Virpik on 29/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

extension TableViewModel {
    struct Handlers {
        typealias DefaultBlock = ((AnyRowModel, UITableViewCell, IndexPath) -> Void)
        // debug
        var handler: Block?
        
        var handlerDidSelect: DefaultBlock?
        var handlerDidDeselect: DefaultBlock?
        
        var handlerWillMove: DefaultBlock?
        var handlerMove: ((AnyRowModel, UITableViewCell, _ at: IndexPath, _ to:IndexPath) -> Void)?
        var handlerDidMove: ((AnyRowModel, UITableViewCell, _ at: IndexPath, _ to:IndexPath) -> Void)?
    }
}
