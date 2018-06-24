//
//  sd.swift
//  EZMobile
//
//  Created by Virpik on 13/12/2017.
//  Copyright © 2017 Sybis. All rights reserved.
//

import Foundation

/// Класс, использовать в структурах
open class TMutableStore <T> {
    public var item: T
    
    public init(item: T) {
        self.item = item
    }
}
