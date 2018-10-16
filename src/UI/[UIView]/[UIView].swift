//
//  TView.swift
//  TSuppot
//
//  Created by Virpik on 28/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit

public extension UIView {
    
    @IBInspectable public var tBRadius: Float {
        get {
            return self.layer.cornerRadius.float
        }
        
        set (value) {
            self.layer.cornerRadius = value.cgFloat
        }
    }
    
    @IBInspectable public var tBColor: UIColor? {
        get {
            
            if let cgColor = self.layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            
            return nil
        }
        
        set (value) {
            self.layer.borderColor = value?.cgColor
        }
    }
    
    @IBInspectable public var tBWidth: Float {
        get {
            return self.layer.borderWidth.float
        }
        
        set (value) {
            self.layer.borderWidth = value.cgFloat
        }
    }
}
