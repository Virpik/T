//
//  TDemo.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

struct TDemoRowModel: RowModelBlocks {
    typealias RowType = TDemoCell
    
    var isMoving: Bool {
        return self._cell.item?.moveAnchor != nil
    }
    
    var movingAnchorView: UIView? {
        return self._cell.item?.moveAnchor
    }
    
    var didSelect: ((RowType, IndexPath) -> Void)?
    var build: ((RowType, IndexPath) -> Void)?
    
    var item: TDemoItem
    
    private var _cell: TMutableStore<RowType?> = TMutableStore<RowType?>(item: nil)
    
    init(item: TDemoItem) {
        self.item = item
    }
    
    func build(cell: RowType, indexPath: IndexPath) {
//        self._cell = cell
        self._cell.item = cell
        
        cell.labelTitle.text = self.item.title
        cell.viewContainer.backgroundColor = self.item.color
        cell.contentView.backgroundColor = self.item.color?.light(-0.2)
        
        self.build?(cell, indexPath)
    }
    
    func didSelect(cell: RowType, indexPath: IndexPath) {

        self.didSelect?(cell, indexPath)
    }
}
