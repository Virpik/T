//
//  [MutableCollections].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

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
