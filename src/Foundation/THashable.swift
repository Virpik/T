//
//  THashable.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

/// Обертка над Hashable, для упрощения получения hashValue значения
/// Для полноченной исопльзования Hashable, необходмио реализовать свойство var hashes: [Int]
///
///struct Object: THashable {
///    var field1: String
///    var field2: String
///    var field3: String?
///
///    var hashes: [Int] {
///        return [
///            self.field1.hashValue,
///            self.field2.hashValue,
///            self.field3.hashValue ?? 0
///        ]
///    }
///}
///
public protocol THashable: Hashable {
    
    /// Список hashValue свойств объекта, которые влияют на уникальность
    var hashes: [Int] { get }
}

public extension THashable {
    public var hashValue: Int {
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
