//
//  [Error][T].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension Error {
    public var code: Int {
        return (self as NSError).code
    }
}
