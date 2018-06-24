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
public typealias BlockForItem<T> = ((T) -> Void)
public typealias BlockSuccess<T> = ((T) -> Void)
public typealias BlockFake<T> = ((TimeInterval, T?, Error?) -> Void)
public typealias BlocksWorker<T> = (success: BlockSuccess<T>?, fail: BlockFail?)

public struct Handlers<T> {
    public var fail: BlockFail?
    public var success: BlockSuccess<T>?
    public var fake: BlockFake<T>?
}

public func async(_ block: @escaping Block) {
    DispatchQueue.global().async(execute: block)
}

public  func main(_ block: @escaping Block) {
    DispatchQueue.main.async(execute: block)
}

public func delay(_ delay: TimeInterval, _ block: @escaping Block) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: block)
}

public func tLog(file: String = #file, func: String = #function,
                 line: Int = #line,
                 tag: String? = nil,
                 _ args: Any?...) {
    
    let _file: NSString = file as NSString
    
    let tag: String = "#[\(_file.lastPathComponent)][\(`func`)][\(line)]#[\(tag?.uppercased() ?? "")]"
    
    let str: String = args.compactMap {
        return "\($0 ?? "#NIL#") "
    }.joined()
    
    print(tag, str)
}

public func timeLog(func: String = #function,
                    line: Int = #line,
                    _ block: (() -> Void)) {
    let date = Date()
    
    block()
    
    let nDate = Date()
    
    let tt = nDate.timeIntervalSince(date)
    
    tLog(func: `func`, line: line, tag: "Time", "\(tt/1000)" )
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
