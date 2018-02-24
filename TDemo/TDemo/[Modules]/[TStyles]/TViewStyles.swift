//
//  TViewStyles.swift
//  TDemo
//
//  Created by Virpik on 24/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation
import T

struct TViewStyles {
    static var view1: T.Styles.View {
        var style = T.Styles.View()
        
        style.bgColor = UIColor.red.t.transparency(0.3)
        style.bordeWidth = 3
        style.borderColor = .green
        style.cornerRadius = 5
        
        return style
    }
    
    static var view2: T.Styles.View {
        var style = T.Styles.View()
        
        style.bgColor = UIColor.blue.t.transparency(0.3)
        
        style.bordeWidth = 1
        style.borderColor = .gray
        style.cornerRadius = 10
        
        return style
    }
}
