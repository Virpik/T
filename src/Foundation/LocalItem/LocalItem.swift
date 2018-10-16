//
//  LocalItem.swift
//  Starateli
//
//  Created by Virpik on 31/05/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

/// Обертка над UserDefaults.standard
/// Менеджерит Указанный тип по заданному ключу
///
/// Если объект нативно не сохраняетя, необходмо задать блоки
/// - transformSave: ((T) -> Any)?
/// - transformRestore: ((Any) -> T?)?
///
public struct LocalItem<T> {
    public var key: String /// Ключ в UserDefaults
    
    /// Блок, должен вернуть подготовленный, для сохранения объект
    public var transformSave: ((T) -> Any)?
    /// Блок, должен вернуть восстановленный объект
    public var transformRestore: ((Any) -> T?)?
    
    /// Значение. При заполненеи сразу сохраняет в UserDefaults.
    public var value: T? {
        get {
            guard let any = UserDefaults.standard.value(forKey: self.key) else {
                return nil
            }

            guard let resore = self.transformRestore else {
                return any as? T
            }
            
            return  resore(any)
        }
        
        set(value) {
            self.set(value: value)
        }
    }
    
    
    public init (key: String) {
        self.key = key
    }
    
    /// Задает значение в UserDefaults
    public func set(value: T?) {
        guard let _value = value else {
            tLog(value)
            
            UserDefaults.standard.removeObject(forKey: self.key)
            tLog(value, self.value)
            return
        }
        
        guard let save = self.transformSave else {
            UserDefaults.standard.set(_value, forKey: self.key)
            return
        }
        
        let item = save(_value)
        UserDefaults.standard.set(item, forKey: self.key)
    }
}
