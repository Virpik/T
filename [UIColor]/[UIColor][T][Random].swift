//
//  [UIColor][T][Random].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension UIColor.ExtStatic {
    public static func random() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}
