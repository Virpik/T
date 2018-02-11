//
//  EssayCardRowModel.swift
//  TDemo
//
//  Created by Virpik on 09/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation
import T

struct EssaysCartRowModel: RowModelBlocks {
    typealias RowType = UITableViewCell
    
    let item: Essay

    var build: ((RowType, IndexPath) -> Void)?
    var didSelect: ((RowType, IndexPath) -> Void)?

    init(item: Essay) {
        self.item = item
    }
    
    func build(cell: RowType, indexPath: IndexPath) {
        
        /// 
        
        self.build?(cell, indexPath)
    }
}
