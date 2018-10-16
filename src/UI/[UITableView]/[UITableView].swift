//
//  [UITableView].swift
//  Pods-TDemo
//
//  Created by Virpik on 02/02/2018.
//


import Foundation

public extension UITableView {
    
    public func belowCell(at indexPath: IndexPath) -> UITableViewCell? {
        guard let indexPath = self.below(at: indexPath) else {
            return nil
        }
        
        return self.cellForRow(at: indexPath)
    }
    
    public func aboveCell(at indexPath: IndexPath) -> UITableViewCell? {
        guard let indexPath = self.above(at: indexPath) else {
            return nil
        }
        
        return self.cellForRow(at: indexPath)
    }
    
    public func below(at indexPath: IndexPath) -> IndexPath? {
        var section = indexPath.section
        var row = indexPath.row
        
        let sections = self.numberOfSections
        let rowsAtSection = self.numberOfRows(inSection: section)
        
        if rowsAtSection - 1 == row && sections - 1 == section {
            return nil
        }
        
        if rowsAtSection - 1 > row {
            row += 1
            
            return IndexPath(row: row, section: section)
        }
        
        if sections - 1 > section {
            section += 1
            row = 0
            
            return IndexPath(row: row, section: section)
        }
        
        return nil
    }
    
    public func above(at indexPath: IndexPath) -> IndexPath? {
        var section = indexPath.section
        var row = indexPath.row
        
        if row == 0 && section == 0 {
            return nil
        }
        
        if row > 0 {
            row -= 1
            return IndexPath(row: row, section: section)
        }
        
        if section > 0 {
            section -= 1
            row = self.numberOfRows(inSection: section) - 1
            return IndexPath(row: row, section: section)
        }
        
        return nil
    }
}

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
