//
//  TArray.swift
//  TDemo
//
//  Created by Virpik on 02/11/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

public extension Array {
    public func item(atIndex index: Int) -> Element? {
        if self.count <= index {
            return nil
        }
        
        if index < 0 {
            return nil
        }
        
        return self[index]
    }

    public mutating func move(at: Int, to: Int) {
        let item = self[at]
        
        self.remove(at: at)
        self.insert(item, at: to)
    }
}

public extension Collection {
    public var shuffle: [Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

public extension MutableCollection where Index == Int {
    public mutating func shuffleInPlace() {
        if self.count < 2 {
            return
        }
        
        for i in 0 ..< Int(self.count) - 1 {
            
            let j = Int(arc4random_uniform(UInt32(Int(self.count) - i))) + i
            
            guard i != j else {
                continue
            }
            
            self.swapAt(i, j)
        }
    }
}
