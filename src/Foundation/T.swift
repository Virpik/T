//
//  T.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

public struct T {}

public typealias Block = (() -> Void)
public typealias BlockFail = ((Error) -> Void)
public typealias BlockItem<T> = ((T) -> Void)
public typealias BlockFake<T> = ((TimeInterval, T?, Error?) -> Void)
public typealias BlocksWorker<T> = (success: BlockItem<T>?, fail: BlockFail?)

public struct Handlers<T> {
    public var fail: BlockFail?
    public var success: BlockItem<T>?
    public var fake: BlockFake<T>?
}

/// Выполнение блока в дефолтной, асинхронной очереди
public func async(_ block: @escaping Block) {
    DispatchQueue.global().async(execute: block)
}

/// Выполнение блока в главной очереди
public  func main(_ block: @escaping Block) {
    DispatchQueue.main.async(execute: block)
}

/// Выполнение блока с задержкой в указанной очереди (по умолчанию в главной)
public func delay(queue: DispatchQueue = DispatchQueue.main, _ delay: TimeInterval, _ block: @escaping Block) {
    queue.asyncAfter(deadline: .now() + delay, execute: block)
}

/// For Tests
public extension T {
    public static func coderInstance<T: NSCoding>(_ initBlock: (() -> T)) -> T? {
        
        let obj = initBlock()
        
        let archiverData = NSMutableData()
        
        let archiver = NSKeyedArchiver(forWritingWith: archiverData)
        archiver.encode(obj, forKey: "view")
        archiver.finishEncoding()
        
        let unarchve = NSKeyedUnarchiver(forReadingWith: archiverData as Data)
        
        return unarchve.decodeObject(forKey: "view") as? T
    }
}
