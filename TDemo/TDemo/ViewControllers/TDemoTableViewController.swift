//
//  TDemoTableViewController.swift
//  TDemo
//
//  Created by Virpik on 22/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

class TDemoTableViewController: TTableModelViewController {
    struct Item {
        var title: String?
        var color: UIColor?
        
        init(title: String?, color: UIColor?) {
            self.title = title
            self.color = color
        }
    }
    
    private var items: [Item] = {
        
        return [
            Item(title: "Title1", color: .red.withAlphaComponent(0.3)),
            Item(title: "Title2", color: .green.withAlphaComponent(0.3)),
            Item(title: "Title3", color: .blue.withAlphaComponent(0.3)),
            Item(title: "Title4", color: .purple.withAlphaComponent(0.3)),
            Item(title: "Title5", color: .orange.withAlphaComponent(0.3)),
            Item(title: "Title6", color: .cyan.withAlphaComponent(0.3))
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
