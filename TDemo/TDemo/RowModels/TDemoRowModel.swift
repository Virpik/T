//
//  TDemo.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit
import T

public struct TDemoRowModel: RowModelBlocks {
    public typealias RowType = TDemoCell
    
    public var isMoving: Bool {
        return self._cell.item?.moveAnchor != nil
    }
    
    public var movingAnchorView: UIView? {
        return self._cell.item?.moveAnchor
    }
    
    public var didSelect: ((RowType, IndexPath) -> Void)?
    public var build: ((RowType, IndexPath) -> Void)?
    
    var item: TDemoItem
    
    private var _cell: TMutableStore<RowType?> = TMutableStore<RowType?>(item: nil)
    
    init(item: TDemoItem) {
        self.item = item
    }
    
    public func build(cell: RowType, indexPath: IndexPath) {
//        self._cell = cell
        self._cell.item = cell
        
        cell.labelTitle.text = self.item.title
        cell.viewContainer.backgroundColor = self.item.color
        cell.contentView.backgroundColor = self.item.color?.light(-0.2)
        
        self.build?(cell, indexPath)
    }
    
    public func didSelect(cell: RowType, indexPath: IndexPath) {

        self.didSelect?(cell, indexPath)
    }
}
