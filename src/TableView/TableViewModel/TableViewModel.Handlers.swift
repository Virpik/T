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

        public var handlerDidScroll: ((UIScrollView) -> Void)?

        public var handlerDidSelect: DefaultBlock?
        public var handlerDidDeselect: DefaultBlock?

        public var moveHandlers: MoveHandlers?
        
        public init() {
            
        }
    }
    
    public struct MoveHandlers {
        
        /// Захват ячейки перемещения
        public var handlerBeginMove: ((_ context: CellContext) -> Void)?
        
        /// Каждый такт перемещения захваченой ячейки (context.indexPath == to || != to)
        public var handlerMove: ((_ atContext: CellContext, _ toContext: CellContext?) -> Void)?
        
        /// При перемещении ячейки в таблице (context.indexPath != to)
        public var handlerDidMove: ((_ atContext: CellContext, _ toContext: CellContext) -> Void)?
        
        /// При очищении контекста захваченой ячейки
        public var handlerEndMove: ((_ atContext: CellContext, _ toContext: CellContext?) -> Void)?
        
        public init() {
            
        }
    }
}

