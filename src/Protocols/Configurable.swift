//
//  File.swift
//  EZMobile
//
//  Created by Virpik on 21/05/2018.
//  Copyright © 2018 Sybis. All rights reserved.
//

import Foundation

/// Протокол, позволяющий получать новый объект на основе текущего
public protocol Configurable {
    /// Метод, для получения нового объекта
    /// В блоке 'block' необходимо его сконфигурировать
    func set(_ block: ((inout Self) -> Void)) -> Self
}

extension Configurable {
    /// Дефолтная реализация протокола Configurable
    public func set(_ block: ((inout Self) -> Void)) -> Self {
        var _self = self
        
        block(&_self)
        
        return _self
    }
}
