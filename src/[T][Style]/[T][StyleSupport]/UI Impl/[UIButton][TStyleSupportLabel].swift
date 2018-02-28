//
//  [UIButton][TStyleSupport].swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension UIButton: TStyleSupportLabel {
    @objc public dynamic var aTextColor: UIColor {
        get {
            return self.titleColor(for: .normal) ?? .red
        }
        
        set (value) {
            self.setTitleColor(value, for: .normal)
        }
    }
    
    @objc public dynamic var aTextFont: UIFont {
        get {
            return self.titleLabel?.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        
        set (value) {
            self.titleLabel?.font = value
        }
    }
    
    @objc public dynamic var aTextSize: Float {
        get {
            return self.aTextFont.pointSize.float
        }
        
        set (value) {
            self.aTextFont = self.aTextFont.withSize(value.cgFloat)
        }
    }
}
