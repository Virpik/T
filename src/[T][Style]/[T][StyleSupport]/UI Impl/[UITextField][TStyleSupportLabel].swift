//
//  [UITextField][TStyleSupportLabel].swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension UITextField: TStyleSupportLabel {
    
    @objc public dynamic var aTextColor: UIColor {
        get {
            return self.textColor ?? .black
        }
        
        set (value) {
            self.textColor = value
        }
    }
    
    @objc public dynamic var aTextFont: UIFont {
        get {
            return self.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        
        set (value) {
            self.font = value
        }
    }
    
    @objc public dynamic var aTextAlignment: NSTextAlignment {
        get {
            return self.textAlignment
        }
        
        set (value) {
            self.textAlignment = value
        }
    }
}
