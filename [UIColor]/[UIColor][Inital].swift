//
//  [UIColor][Inital].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension UIColor {
    public convenience init(hex: Int) {
        let red = Float((hex & 0xFF0000) >> 16) / 255.0
        let green = Float((hex & 0xFF00) >> 8) / 255.0
        let blue = Float(hex & 0xFF) / 255.0
        
        self.init(red: red.cgFloat, green: green.cgFloat, blue: blue.cgFloat, alpha: 1.0)
    }
    
    public convenience init(sHex: String) {
        let hex = sHex
        
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt32 = 0
        
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
