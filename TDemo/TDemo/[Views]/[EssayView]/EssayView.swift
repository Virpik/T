//
//  EssayView.swift
//  TDemo
//
//  Created by Virpik on 09/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import UIKit
import T

@IBDesignable
class EssayView: UIView {
    
    @IBOutlet var labelTitle: UILabel?
    @IBOutlet var labelBody: UILabel?
    @IBOutlet var labelDateAt: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup(fromXib: "\(self.classForCoder)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup(fromXib: "\(self.classForCoder)")
    }

    func setup(essay: Essay) {
        self.labelBody?.text = essay.body
        self.labelTitle?.text = essay.title
        self.labelDateAt?.text = essay.dateAt.string(format: "DD/MM/YYY hh:mm")
    }
}
