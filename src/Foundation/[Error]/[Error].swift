//
//  [Error][T].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension Error {
    
    /// Код ошибки
    public var code: Int {
        return (self as NSError).code
    }
}
