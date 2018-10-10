//
//  Row.swift
//  T
//
//  Created by Virpik on 26/06/2018.
//

import Foundation

public struct Row<T: UITableViewCell>: RowModelBlocks {
    public typealias RowType = T
    
    public var isNib: Bool
    
    public var build: ((T, IndexPath) -> Void)?
    public var didSelect: ((T, IndexPath) -> Void)?
    
    public init(isNib: Bool = false) {
        self.isNib = isNib
    }
}
