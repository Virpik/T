//
//  SimulatioAppViewController.swift
//  TDemo
//
//  Created by Virpik on 21/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation
import UIKit
import T


class SimulatioAppViewController: TTableModelViewController {
    private var _default = Settings()
    
    lazy var fieldName: FieldStr = {
        return FieldStr()
    }()
    
    lazy var fieldPhone: FieldStr = {
        return FieldStr()
    }()
    
    lazy var fieldCity: FieldStr = {
        return FieldStr()
    }()
    
    lazy var fieldsColors: [FieldColor] = {
        return []
    }()
    
    lazy var fieldAddNewColor: FieldAddNewColor = {
        return FieldAddNewColor()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rowsMain = [ self.fieldName, self.fieldPhone, self.fieldCity]
        let rowsColor = self.fieldsColors
        let other = [self.fieldAddNewColor]
        
        self.fieldAddNewColor.didSelect = self._addNewColor
        
        self.set(rows: [rowsMain, rowsColor, other])
    }
    
    func show(setting: Settings) {
        self.fieldName.build = { cell, _ in
            self._build(cell: cell, str: setting.field_name)
        }
        
        self.fieldPhone.build = { cell, _ in
            self._build(cell: cell, str: setting.field_name)
        }
        
        self.fieldCity.build = { cell, _ in
            self._build(cell: cell, str: setting.field_name)
        }
        
        let colors: [AnyRowModel] = setting.fields_colors.map({ (color) -> FieldColor in
           var field = FieldColor()

            field.build = { cell, indexPath in
                cell.viewMarker.backgroundColor = color
            }
            
            field.didSelect = { cell, indexPath in
                
            }
            
            return field
        })
        
        self.tableViewModel.sections[1] = colors
        
        self.tableView.reloadData()
    }
    
    private func _addNewColor(cell: SettingFieldStrCell, indexPath: IndexPath) {
        
    }
    
    private func _build(cell: SettingFieldStrCell, str: String?) {
        let isNull = str == nil
        cell.labelText.textColor =  isNull ? UIColor.gray : UIColor.black
        cell.labelText.text = str
    }
}
