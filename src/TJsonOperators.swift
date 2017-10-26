//
//  TJsonOperators.swift
//  ecm
//
//  Created by Virpik on 10/04/2017.
//  Copyright © 2017 Sybis. All rights reserved.
//

import Foundation

//public typealias TJson = [String: Any]
//
//protocol TJsonObject {
//    init?(data: TJson)
//}
//
//precedencegroup MultiplicationPrecedence {
//    associativity: left
//    higherThan: AdditionPrecedence
//}
//
//infix operator <=- : MultiplicationPrecedence
//infix operator -=> : MultiplicationPrecedence
//
//func <=- <T: TJsonObject> (left: TJson, right: String) -> [T] {
//    if let tmp = left[right] as? [TJson] {
//        let objects: [T?] = tmp.map ({
//            T(data: $0)
//        })
//        
//        return objects.filter({
//            return $0 != nil
//        }) as! [T]
//    }
//    
//    return []
//}
// 
//func <=- <T: TJsonObject> (left: TJson, right: String) -> T? {
//    if let tmp = left[right] as? TJson {
//        return T(data: tmp)
//    }
//    
//    return nil
//}
//
//func <=- <T> (left: TJson, right: String) -> T? {
//    return left[right] as? T
//}
//
//func <=- <T> (left: TJson?, right: String) -> T? {
//    return left?[right] as? T
//}

//func -=> <T> (left: (value: T, key: String), right: TJson) {
//    var right = right
//    right[left.key] = left.value
//}
//
//func -=> <T> (left: (value: T?, key: String), right: TJson) {
//    if let value = left.value {
//        (value, left.key) -=> right
//    }
//}
