//
//  TExtension.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit
/*
public extension Sequence where Iterator.Element == String?  {
    public func string(escape: String = "\n") -> String {
        var str = ""
        
        self.enumerated().forEach({
            if let _str = $1 {
                str += _str
                str += escape
            }
        })
        
        return str
    }
}
*/
public extension UITableView {
    public func setupAutomaticDimension(estimatedHeight: CGFloat = 40) {
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = estimatedHeight
    }
    
    public func setupAutomaticDimensionHeader(estimatedHeight: CGFloat = 40) {
        self.sectionHeaderHeight = UITableViewAutomaticDimension
        self.estimatedSectionHeaderHeight = estimatedHeight
    }
    
    public func setupAutomaticDimensionFooter(estimatedHeight: CGFloat = 40) {
        self.sectionFooterHeight = UITableViewAutomaticDimension
        self.estimatedSectionFooterHeight = estimatedHeight
    }
    
    public func registerHead<View: UITableViewHeaderFooterView> (type: View.Type) {
        let idendifier = self.cellIdendifier(atClass: type)
        let nib = UINib(nibName: "\(type.classForCoder())", bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: idendifier)
    }
    
    public func head<View: UITableViewHeaderFooterView> (type: View.Type) -> View? {
        let idendifier = self.cellIdendifier(atClass: type)
        return self.dequeueReusableHeaderFooterView(withIdentifier: idendifier) as? View
    }
    
    public func register<TCell: UITableViewCell> (type: TCell.Type, isNib: Bool = true) {
        let idendifier = self.cellIdendifier(atClass: type)
        
        if isNib {
            let nib = UINib(nibName: "\(type.classForCoder())", bundle: nil)
            self.register(nib, forCellReuseIdentifier: idendifier)
        } else {
            self.register(type, forCellReuseIdentifier: idendifier)
        }
    }
    
    public func cell<TCell: UITableViewCell> (type: TCell.Type) -> TCell? {
        let idendifier = self.cellIdendifier(atClass: type)
        return self.dequeueReusableCell(withIdentifier: idendifier) as? TCell
    }
    
    public func cellIdendifier(atClass: AnyClass) -> String {
        return "\(atClass)"
    }
}
