//
//  RowModelBlocks.swift
//  TDemo
//
//  Created by Virpik on 21/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

public protocol RowModelBlocks: RowModel {
    var build: ((RowType, IndexPath) -> Void)? { get set }
    var didSelect: ((RowType, IndexPath) -> Void)? { get set }
}

public extension RowModelBlocks {
    public func build(cell: RowType, indexPath: IndexPath) {
        self.build?(cell, indexPath)
    }
    
    public func didSelect(cell: RowType, indexPath: IndexPath) {
        self.didSelect?(cell, indexPath)
    }
}

