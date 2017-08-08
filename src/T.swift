//
//  T.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

public func async(_ block: @escaping () -> Void) {
    DispatchQueue.global().async(execute: block)
}

public  func main(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}

public func delay(_ delay: TimeInterval, _ block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: block)
}
