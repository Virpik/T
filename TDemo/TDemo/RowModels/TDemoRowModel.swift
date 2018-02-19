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
    
    var blockDelete: ((TDemoItem) -> Void)?
    var blockAddToBottom: ((TDemoItem) -> Void)?
    
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
        cell.contentView.backgroundColor = self.item.color?.t.light(-0.2)
        
        var handlers = RowType.Handlers()
        
        handlers.addToCart = {
            self.blockAddToBottom?(self.item)
        }
        
        handlers.delete = {
            self.blockDelete?(self.item)
        }
        
        cell.handlers = handlers
        
        self.build?(cell, indexPath)
    }
    
    public func didSelect(cell: RowType, indexPath: IndexPath) {

        self.didSelect?(cell, indexPath)
    }
}
