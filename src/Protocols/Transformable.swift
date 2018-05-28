//
//  Transformable.swift
//  EZMobile
//
//  Created by Virpik on 23/05/2018.
//  Copyright © 2018 Sybis. All rights reserved.
//

import Foundation

/// Протокол, позволяющий "Трансформировать" Создать новый объект произвольного типа,
/// на онове текущего.
public protocol Transformable {
    func transform<T>(_ block: (Self) -> T) -> T
}

extension Transformable {
    /// Дефолтная реализация протокола
    public func transform<T>(_ block: (Self) -> T) -> T {
        return block(self)
    }
}
