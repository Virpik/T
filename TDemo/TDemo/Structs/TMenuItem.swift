//
//  TMenuItem.swift
//  TDemo
//
//  Created by Virpik on 21/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import T

struct TMenuItem {
    var title: String?
    var block: Block?
    
    init(title: String?, block: Block?) {
        self.title = title
        self.block = block
    }
}
