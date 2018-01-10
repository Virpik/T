//
//  RowModelBlocks.swift
//  TDemo
//
//  Created by Virpik on 21/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

protocol RowModelBlocks: RowModel {
    var build: ((RowType, IndexPath) -> Void)? { get set }
    var didSelect: ((RowType, IndexPath) -> Void)? { get set }
}

extension RowModelBlocks {
    func build(cell: RowType, indexPath: IndexPath) {
        self.build?(cell, indexPath)
    }
    
    func didSelect(cell: RowType, indexPath: IndexPath) {
        self.didSelect?(cell, indexPath)
    }
}
