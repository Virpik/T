//
//  TArray.swift
//  TDemo
//
//  Created by Virpik on 02/11/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

extension Array {
    func item(atIndex index: Int) -> Element? {
        if self.count <= index {
            return nil
        }
        
        if index < 0 {
            return nil
        }
        
        return self[index]
    }
}

extension Array {
    mutating func move(at: Int, to: Int) {
        let item = self[at]
        
        self.remove(at: at)
        self.insert(item, at: to)
    }
}
