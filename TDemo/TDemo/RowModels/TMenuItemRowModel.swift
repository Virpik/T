//
//  TMenuItemRowModel.swift
//  TDemo
//
//  Created by Virpik on 21/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit
import T

struct TMenuItemRowModel: RowModelBlocks {
    typealias RowType = TMenuItemCell
    
    var didSelect: ((TMenuItemCell, IndexPath) -> Void)?
    var build: ((TMenuItemCell, IndexPath) -> Void)?
    
    var menuItem: TMenuItem
    
    init(menuItem: TMenuItem) {
        self.menuItem = menuItem
    }
    
    func build(cell: TMenuItemCell, indexPath: IndexPath) {
        cell.lableTitle.text = self.menuItem.title
        self.build?(cell, indexPath)
    }
    
    func didSelect(cell: TMenuItemCell, indexPath: IndexPath) {
        self.menuItem.block?()
        self.didSelect?(cell, indexPath)
    }
}
