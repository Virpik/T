//
//  TStylesViewController.swift
//  TDemo
//
//  Created by Virpik on 24/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation
import T

class TStylesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.aBackgroundColor = .white
        
        let size = CGSize(width: 240, height: 40)

        let view = UIView(size: size)
        view.frame.origin = CGPoint(x: 16, y: 16)

        let label = UILabel(size: size)
        label.frame.origin = view.frame.t.max.t.set(x: 16).t.sum(y: 16)
        label.text = "[Label]"
        
        let textField = UITextField(size: size)
        textField.frame.origin = label.frame.t.max.t.set(x: 16).t.sum(y: 16)
        textField.text = "[TextField]"
        textField.placeholder = "[TextField Placeholder]"
        
        let button = UIButton(size: size)
        button.frame.origin = textField.frame.t.max.t.set(x: 16).t.sum(y: 16)
        button.setTitle("[Button]", for: .normal)
        
        view.apply(style: TViewStyles.view1)
        label.apply(style: TViewStyles.view2)
        textField.apply(style: TViewStyles.view1)
        button.apply(style: TViewStyles.view2)

        label.apply(style: TLabelStyles.label1)
        textField.apply(style: TLabelStyles.label2)
        button.apply(style: TLabelStyles.label3)
        
        view.clipsToBounds = true
        label.clipsToBounds = true
        textField.clipsToBounds = true
        button.clipsToBounds = true
        
        self.view.addSubview(view)
        self.view.addSubview(label)
        self.view.addSubview(textField)
        self.view.addSubview(button)
    }
}
