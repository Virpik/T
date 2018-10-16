//
//  TString.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

public extension String {
    
    public var int: Int {
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

public extension StringProtocol where Index == String.Index {
    
    /// range to NSRange
    public func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}

public extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    /// Подстрока по диапазону
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }

    /// Большая первая буква
    public var capitalizingFirstLetter: String {
        let first = self.prefix(1).capitalized
        let other = self.dropFirst()
        return first + other
    }
}

/// Набор методов по работе с путями из NSString (Это было удобно)
public extension String {
    
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    public var abbreviatingWithTildeInPath: String {
        return (self as NSString).abbreviatingWithTildeInPath
    }
    
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    public func appendingPathExtension(_ str: String) -> String {
        return (self as NSString).appendingPathExtension(str) ?? self+"."+str
    }
}
