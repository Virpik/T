//
//  EssayView.swift
//  TDemo
//
//  Created by Virpik on 09/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import UIKit
import T

class EssayView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup(fromXib: "\(self.classForCoder)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup(fromXib: "\(self.classForCoder)")
        
    }
    

}
