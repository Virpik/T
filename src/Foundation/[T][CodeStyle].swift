//
//  File.swift
//  T
//
//  Created by Virpik on 16/10/2018.
//

import Foundation

/// Для приятного форматирования кода, метод позволяет проводить работы по конфигурации объекта в блоке
public func configure<T>(item: T, _ block: ((inout T) -> Void)) -> T {
    var item = item
    block(&item)
    return item
}

/// Вывод подробного лога
public func tLog(file: String = #file,
                 func: String = #function,
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

/// Логирование времений работы блока
public func timeLog(func: String = #function, line: Int = #line, _ block: (() -> Void)) {
    
    let date = Date()
    
    block()
    
    let nDate = Date()
    
    let tt = nDate.timeIntervalSince(date)
    
    tLog(func: `func`, line: line, tag: "Time", "\(tt/1000)" )
}
