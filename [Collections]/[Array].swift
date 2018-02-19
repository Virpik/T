//
//  [Array].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
