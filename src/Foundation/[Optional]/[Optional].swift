//
//  [Optional][T].swift
//  T
//
//  Created by Virpik on 17/06/2018.
//

import Foundation

public extension Optional {
    public enum Errors: Error {
        case isNil
    }
    
    public func `throw`() throws -> Wrapped {
        switch self {
        case .none:
            throw Errors.isNil
        case .some(let item):
            return item
        }
    }
}
