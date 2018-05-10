//
//  TViewController.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func show(vc: UIViewController, isAnimate: Bool) {
        var viewControllers = self.navigationController?.viewControllers ?? []
        viewControllers.append(vc)
        self.navigationController?.setViewControllers(viewControllers, animated: isAnimate)
    }
}

public extension UIViewController {
    
    @objc public func backAction(sender: Any?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func chponks() {
        let tView = UIView.defaultScreen()
        
        tView.backgroundColor = UIColor.t.random().t.transparency(0.8)
        tView.frame = self.view.bounds
        
        let tLabel = UILabel.defaultScreen()
        tLabel.frame = self.view.bounds
        
        tLabel.textAlignment = .center
        tLabel.text = String(describing: self.classForCoder)
        tLabel.textColor = tView.backgroundColor?.t.invert().t.transparency(1)
            
        tView.t_view.addSubview(view: tLabel)
        self.view.t_view.addSubview(view: tView)
    }

}

