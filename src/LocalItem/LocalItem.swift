//
//  LocalItem.swift
//  Starateli
//
//  Created by Virpik on 31/05/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

public struct LocalItem<T> {
    public var key: String
    
    public var transformSave: ((T) -> Any)?
    public var transformRestore: ((Any) -> T?)?
    
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
            guard let _value = value else {
                UserDefaults.standard.set(value, forKey: self.key)
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
    
    
    public init (key: String) {
        self.key = key
    }
}
