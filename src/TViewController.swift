//
//  TViewController.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    public func chponks() {
        let tView = UIView.defaultScreen()
        
        tView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        tView.frame = self.view.bounds
        
        let tLabel = UILabel.defaultScreen()
        tLabel.frame = self.view.bounds
        
        tLabel.textAlignment = .center
        tLabel.text = String(describing: self.classForCoder)
        
        tView.tAddSubview(view: tLabel)
        self.view.tAddSubview(view: tView)
    }

}

