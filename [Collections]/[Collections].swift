//
//  [Collections].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension Collection {
    public var shuffle: [Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}
