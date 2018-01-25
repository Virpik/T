//
//  TDemoItem.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit
import T

struct TDemoItem: THashable {
    var title: String?
    var color: UIColor?
    
    var hashes: [Int] {
        return [
            self.title?.hashValue ?? 0,
            self.color?.hashValue ?? 0
        ]
    }
    
    init(title: String?, color: UIColor?) {
        self.title = title
        self.color = color
    }
}
