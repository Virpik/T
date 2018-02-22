//
//  SimulationAppViewController.Fields.swift
//  TDemo
//
//  Created by Virpik on 21/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation
import T

extension SimulatioAppViewController {
    struct FieldStr: RowModelBlocks {
        typealias RowType = SettingFieldStrCell
        
        var build: ((RowType, IndexPath) -> Void)?
        var didSelect: ((RowType, IndexPath) -> Void)?
    }
    
    struct FieldColor: RowModelBlocks {
        typealias RowType = SettingFieldColorCell
        
        var build: ((RowType, IndexPath) -> Void)?
        var didSelect: ((RowType, IndexPath) -> Void)?
    }
    
    struct FieldAddNewColor: RowModelBlocks {
        typealias RowType = SettingFieldStrCell
        
        var build: ((RowType, IndexPath) -> Void)?
        var didSelect: ((RowType, IndexPath) -> Void)?
        
        func build(cell: RowType, indexPath: IndexPath) {
            cell.labelText.textAlignment = .center
            cell.labelText.textColor = .blue
            cell.labelText.text = "+ Add new color"
        }
    }
}
