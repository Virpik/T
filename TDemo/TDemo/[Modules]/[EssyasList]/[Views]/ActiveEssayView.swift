//
//  ActiveEssayView.swift
//  TDemo
//
//  Created by Virpik on 12/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation
import UIKit
import T

class ActiveEssayView: UIView {
    
    struct Appearance {
        
    }
    
    lazy var essayView: EssayView = {
        return EssayView(width: 100, height: 100)
    }()
    
    let appearance: Appearance
    
    init(frame: CGRect = .zero, appearance: Appearance = Appearance()) {
        
        self.appearance = appearance
        
        super.init(frame: frame)
        
        self.addSubviews()
        self.makeConstraints()
        self.make(appearance: self.appearance)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func make(appearance: Appearance) {
        self.essayView.tBRadius = 3
        self.backgroundColor = UIColor.gray.transparency(0.3)
    }
    
    func addSubviews() {
        self.addSubview(self.essayView)
    }
    
    func makeConstraints() {
        let marginGuide = self
        
        self.essayView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 8).isActive = true
        self.essayView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 8).isActive = true
        self.essayView.leftAnchor.constraint(equalTo: marginGuide.leftAnchor, constant: 8).isActive = true
        self.essayView.rightAnchor.constraint(equalTo: marginGuide.rightAnchor, constant: 8).isActive = true
    }
}
