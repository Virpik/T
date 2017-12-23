//
//  sd.swift
//  EZMobile
//
//  Created by Virpik on 13/12/2017.
//  Copyright © 2017 Sybis. All rights reserved.
//

import Foundation

/// Класс, использовать в структурах
class TMutableStore <T> {
    var item: T
    
    init(item: T) {
        self.item = item
    }
}
