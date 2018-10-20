//
//  sd.swift
//  EZMobile
//
//  Created by Virpik on 13/12/2017.
//  Copyright © 2017 T. All rights reserved.
//

import Foundation

/// Класс, использовать в структурах
/// Для обхода запсиси в не мутабельных структурах
open class TMutableStore <T> {
    public var item: T
    
    public init(item: T) {
        self.item = item
    }
}
