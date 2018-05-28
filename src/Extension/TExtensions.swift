//
//  TExtension.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

public extension IndexPath {
    public func incRow() -> IndexPath {
        let section = self.section
        let row = self.row
        
        return IndexPath(row: row + 1, section: section)
    }
    
    public func decRow() -> IndexPath {
        let section = self.section
        let row = self.row
        
        return IndexPath(row: row - 1, section: section)
    }
}

public extension CGSize {
    public init (_ width: CGFloat, height: CGFloat) {
        self.init(width: width, height: height)
    }
}

public extension CGRect {
    public init( _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.init(x:x, y:y, width:width, height:height)
    }
}

public extension CGFloat {
    public static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

public extension Int {
    public var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
    
    public var radiansToDegrees: Double {
        return Double(self) * 180 / .pi
    }
}

public extension FloatingPoint {
    public var degreesToRadians: Self {
        return self * .pi / 180
    }
    
    public var radiansToDegrees: Self {
        return self * 180 / .pi
    }
}

public extension String {
    var int: Int {
        return Int(self) ?? 0
    }
    
    public var uInt32: UInt32 {
        if let int = UInt32(self) {
            return int
        }
        
        return 0
    }
    
    public var float: Float {
        if let int = Float(self) {
            return int
        }
        
        return 0
    }
    
    public var double: Double {
        if let int = Double(self) {
            return int
        }
        
        return 0
    }
    
    public var int16: Int16 {
        if let int = Int16(self) {
            return int
        }
        
        return 0
    }
}

public extension Int {
    public var uInt32: UInt32 {
        return UInt32(self)
    }
    
    public var float: Float {
        return Float(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return "\(self)"
    }
    
    public var bool: Bool {
        return (self as NSNumber).boolValue
    }
    
    var number: NSNumber {
        return NSNumber(value: self)
    }
}

public extension Float {
    public var uInt32: UInt32 {
        return UInt32(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var int: Int {
        return Int(self)
    }
    
    public var string: String {
        return "\(self)"
    }
}

public extension CGFloat {
    public var uInt32: UInt32 {
        return UInt32(self)
    }
    
    public var float: Float {
        return Float(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var int: Int {
        return Int(self)
    }
    
    public var string: String {
        return "\(self)"
    }
}

public extension Double {
    public var uInt32: UInt32 {
        return UInt32(self)
    }
    
    public var float: Float {
        return Float(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var int: Int {
        return Int(self)
    }
    
    public var string: String {
        return "\(self)"
    }
    
    public var date: Date {
        return Date(timeIntervalSince1970: self)
    }
}

public extension UInt32 {
    public var float: Float {
        return Float(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var int: Int {
        return Int(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return "\(self)"
    }
}

public extension NSNumber {
    public var float: Float {
        return self.floatValue
    }
    
    public var cgFloat: CGFloat {
        return self.floatValue.cgFloat
    }
    
    public var int: Int {
        return self.intValue
    }
    
    public var double: Double {
        return self.doubleValue
    }
    
    public var string: String {
        return "\(self)"
    }
}

public extension Date {
    public func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    public func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    public func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    
    public func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    public func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    public func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    public func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    public func nanosecond(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    
    public func offset(_ date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        if nanosecond(from: date) > 0 { return ".\(nanosecond(from: date))s" }
        
        return "\(date.timeIntervalSince1970 - self.timeIntervalSince1970)"
    }
}

public extension DateFormatter {
    public var defaultTimeZone: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = self.dateFormat
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }
    
    public convenience init(format: String) {
        self.init()
        
        self.dateFormat = format
    }
}

public extension Date {
    
    public func string(format: String) -> String {
        let formatter = DateFormatter(format: format)
        
        return formatter.string(from: self)
    }
    
    public struct Formatter {
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }()
        
        static let iso1: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH-mm-ss"
            return formatter
        }()
        
        static let iso2: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH-mm-ssZ"
            return formatter
        }()
        
    }
    
    public var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    
    public var iso1: String {
        return Formatter.iso1.string(from: self)
    }
    
    public var iso2: String {
        return Formatter.iso2.string(from: self)
    }
    
    public var iso8601Default: String {
        return Formatter.iso8601.defaultTimeZone.string(from: self)
    }
    
    public var iso1Default: String {
        return Formatter.iso1.defaultTimeZone.string(from: self)
    }
    
    public var iso2Default: String {
        return Formatter.iso2.defaultTimeZone.string(from: self)
    }
}

public extension Sequence where Iterator.Element == String?  {
    public func string(escape: String = "\n") -> String {
        var str = ""
        
        self.enumerated().forEach({
            if let _str = $1 {
                str += _str
                
                //                if $0 != self.count - 1 {
                str += escape
                //                }
            }
        })
        
        return str
    }
}

//extension Dictionary {
//    var json: String {
//
//        do {
//            let data = try JSONSerialization.data(withJSONObject:self, options: .prettyPrinted)
//            return data.string ?? " nil"
//        } catch _ {
//
//        }
//
//        return "nil"
//    }
//}

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
