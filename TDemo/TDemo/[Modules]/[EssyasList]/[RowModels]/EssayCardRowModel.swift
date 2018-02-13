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
    typealias RowType = EssayCardCell
    
    let item: Essay

    var build: ((RowType, IndexPath) -> Void)?
    var didSelect: ((RowType, IndexPath) -> Void)?

    var isMoving: Bool {
        return true
    }
    
    var movingAnchorView: UIView? {
        return self.storeLastBuildRow.item?.anchorView
    }
    
    var storeLastBuildRow: TMutableStore<RowType?> = TMutableStore(item: nil)
    
    init(item: Essay) {
        self.item = item
    }
    
    func build(cell: RowType, indexPath: IndexPath) {
        self.storeLastBuildRow.item = cell
        /// 
        
        self.build?(cell, indexPath)
    }
}
