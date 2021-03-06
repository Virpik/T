//
//  ViewController.swift
//  T
//
//  Created by Virpik on 14/06/2018.
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
        
        tView.backgroundColor = UIColor.random().transparency(0.8)
        tView.frame = self.view.bounds
        
        let tLabel = UILabel.defaultScreen()
        tLabel.frame = self.view.bounds
        
        tLabel.textAlignment = .center
        tLabel.text = String(describing: self.classForCoder)
        tLabel.textColor = tView.backgroundColor?.invert().transparency(1)
        
        tView.addSubview(view: tLabel)
        self.view.addSubview(view: tView)
    }
}
