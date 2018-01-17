//
//  TDemoCell.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import UIKit
import T

public class TDemoCell: UITableViewCell {
    
    struct Handlers {
        var delete: Block?
        var addToCart: Block?
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var moveAnchor: UIView!
    
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var buttonAddToBottom: UIButton!
    
    var handlers: Handlers?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionDelete(_ sender: Any) {
        self.handlers?.delete?()
    }
    
    @IBAction func actionAddToCart(_ sender: Any) {
        self.handlers?.addToCart?()
    }
}
