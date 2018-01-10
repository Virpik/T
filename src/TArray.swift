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

extension Collection {
    var shuffle: [Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollection where Index == Int {
    mutating func shuffleInPlace() {
        
        if count < 2 {
            return
        }
        
        for i in 0 ..< Int(count) - 1 {
            
            let j = Int(arc4random_uniform(UInt32(Int(count) - i))) + i
            
            guard i != j else {
                continue
            }
            
            self.swapAt(i, j)
        }
    }
}
