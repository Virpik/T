//
//  [Optional][T].swift
//  T
//
//  Created by Virpik on 17/06/2018.
//

import Foundation

public extension Optional {
    
    /// Ошибка есть элемент пустой
    public enum Errors: Error {
        case isNil
    }
    
    /// Если 'Optional' пустой, будет ошибка 'isNil', иначе - объект
    public func `throw`() throws -> Wrapped {
        switch self {
        case .none:
            throw Errors.isNil
        case .some(let item):
            return item
        }
    }
}
