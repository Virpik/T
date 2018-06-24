//
//  [UITextField][TStyleSupportTextField].swift
//  T
//
//  Created by Virpik on 16/03/2018.
//

import Foundation
import UIKit

extension NSAttributedString {
    fileprivate func value<T>(by attribute: NSAttributedStringKey) -> T? {
        let attributes = self.attributes(at: 0, effectiveRange: nil)
        
        return attributes[NSAttributedStringKey.foregroundColor] as? T
    }
    
    fileprivate func set(value: Any, by attribute: NSAttributedStringKey) -> NSAttributedString {
        let mAttrStr = NSMutableAttributedString(attributedString: self)
        
        let range = NSRange(location: 0, length: self.string.count)
        mAttrStr.addAttributes([attribute: value], range: range)

        return mAttrStr
    }
}

extension UITextField: TStyleSupportTextField {
    private typealias AtrStrKey = NSAttributedStringKey
    public var aLabel: TStyleSupportLabel {
        return self
    }
    
    public var aView: TStyleSupportView {
        return self
    }
    
    public var aPlaceholder: TStyleSupportLabel {
        
        let impl = TStyleSupportLabelImpl(getTextColor: { () -> UIColor in
            
            let color: UIColor = self.attributedPlaceholder?.value(by: .foregroundColor as AtrStrKey) ?? .black
            
            return color

        }, setTextColor: { (color) in
            
            let attrStr = self.attributedPlaceholder ?? NSAttributedString(string: "")
            
            self.attributedPlaceholder = attrStr.set(value: color, by: .foregroundColor)
        
        }, getTextFont: { () -> UIFont in
            
            let defaultFont = UIFont.systemFont(ofSize: 14)
            
            let font: UIFont = self.attributedPlaceholder?.value(by: .font as AtrStrKey) ?? defaultFont
            
            return font
        }, setTextFont: { (font) in
            let attrStr = self.attributedPlaceholder ?? NSAttributedString(string: "")
            self.attributedPlaceholder = attrStr.set(value: font, by: .font)
            
        }, getTextAlignment: { () -> NSTextAlignment in
           
            let aligment: NSParagraphStyle? = self.attributedPlaceholder?.value(by: .paragraphStyle as AtrStrKey)

            return aligment?.alignment ?? .left


            
        }) { (textAligment) in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAligment
            
            let attrStr = self.attributedPlaceholder ?? NSAttributedString(string: "")
            self.attributedPlaceholder = attrStr.set(value: paragraphStyle, by: .paragraphStyle)
        }
        
        return impl
    }
    
}
