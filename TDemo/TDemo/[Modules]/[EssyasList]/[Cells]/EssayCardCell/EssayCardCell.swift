//
//  EssayCardCell.swift
//  TDemo
//
//  Created by Virpik on 09/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import UIKit
import T

class EssayCardCell: UITableViewCell {

    @IBOutlet weak var essayView: EssayView!
    @IBOutlet weak var anchorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
