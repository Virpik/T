//
//  [UINavigationController][T][Appearance].swift
//  T
//
//  Created by Virpik on 11/04/2018.
//

import Foundation

public extension UINavigationController {
    
    /// Удаляет линию под navigation bar
    /// [ВАЖНО] isTranslucent = false
    public func clearBottomLine() {
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    /// Сбрасывает линию под navigation bar
    public func resetBottomLine() {
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.shadowImage = nil
    }
}
