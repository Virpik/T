//
//  TLabelStyles.swift
//  TDemo
//
//  Created by Virpik on 24/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation
import T

struct TLabelStyles {
    static var label1: T.Styles.Label {
        var style = T.Styles.Label()
        
        style.textColor = UIColor.brown
        style.textFont = UIFont(name: "Helvetica-Light", size: 20)
        
        return style
    }
    
    static var label2: T.Styles.Label {
        var style = T.Styles.Label()
        
        style.textColor = UIColor.blue
        style.textFont = UIFont(name: "Helvetica-Bold", size: 20)
        style.textSize = 12
        
        return style
    }
    
    static var label3: T.Styles.Label {
        var style = T.Styles.Label()
        
        style.textColor = UIColor.cyan
        style.textFont = UIFont(name: "HelveticaNeue-Italic", size: 20)
        style.textSize = 16
        
        return style
    }
}
