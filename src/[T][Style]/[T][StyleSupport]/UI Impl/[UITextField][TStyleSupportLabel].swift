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
    
    @objc public dynamic var aTextSize: Float {
        get {
            return self.aTextFont.pointSize.float
        }
        
        set (value) {
            self.font = self.aTextFont.withSize(value.cgFloat)
        }
    }
}
