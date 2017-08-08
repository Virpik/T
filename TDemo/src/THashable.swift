//
//  THashable.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

public protocol THashable: Hashable {
    var hashes: [Int] { get }
}

public extension THashable {
    var hashValue: Int {
        return self.hashes.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
}

public extension Hashable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
