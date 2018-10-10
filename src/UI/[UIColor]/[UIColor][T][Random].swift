//
//  [UIColor][T][Random].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension UIColor {
    public func random() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}

public extension UIColor {
    public static func random(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}

public extension UIColor {
    public static func _random(alpha: CGFloat = 0.2) -> UIColor {
        return UIColor.random().transparency(alpha)
    }
}
