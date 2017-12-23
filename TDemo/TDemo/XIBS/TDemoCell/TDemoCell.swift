//
//  TDemoCell.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import UIKit

class TDemoCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var moveAnchor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
