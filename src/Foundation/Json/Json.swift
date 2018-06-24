//
//  JsonOperators.swift
//  ecm
//
//  Created by Virpik on 10/04/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

public typealias Json = [String: Any]
/**
precedencegroup MultiplicationPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

infix operator <<~ : MultiplicationPrecedence

public func <<= <T> (left: [AnyHashable: Any], right: AnyHashable) -> T? {
    return left[right] as? T
}

infix operator <=- : MultiplicationPrecedence
infix operator -=> : MultiplicationPrecedence

public func <=- <T: JsonInital> (left: Json, right: String) -> [T] {
    if let tmp = left[right] as? [Json] {
        return tmp.map { T(json: $0) }
    }
    
    return []
}

public func <=- <T: JsonInital> (left: Json, right: String) -> T? {
    if let tmp = left[right] as? Json {
        return T(json: tmp)
    }
    
    return nil
}

public func <=- <T> (left: Json, right: String) -> T? {
    return left[right] as? T
}

public func <=- <T> (left: Json?, right: String) -> T? {
    return left?[right] as? T
}

//func -=> <T> (left: (value: T, key: String), right: Json) {
//    var right = right
//    right[left.key] = left.value
//}
//
//func -=> <T> (left: (value: T?, key: String), right: Json) {
//    if let value = left.value {
//        (value, left.key) -=> right
//    }
//}
 */
