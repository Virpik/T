//
//  TString.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation


public extension StringProtocol where Index == String.Index {
    
    /// range to NSRange
    public func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}

public enum TStringDecline: String {
    case TOne, TMany, TOther
}

public extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }

    public var capitalizingFirstLetter: String {
        let first = self.prefix(1).capitalized
        let other = self.dropFirst()
        return first + other
    }
    
    public var localize: String {
        return self.localize()
    }
    
    public func localize(comment: String? = "", count: Int? = nil) -> String {
        var str = self
        
        if let _count = count {
            str +=  "-"+self.declension(_count).rawValue
        }
        
        return  NSLocalizedString(str, comment: "")
    }
    
    private func declension(_ count: Int) -> TStringDecline {
        
        if (count % 10 == 1) && (count != 11) {
            return .TOne
        }
        
        if (count >= 5) && (count <= 20) {
            return .TMany
        }
        
        if (count % 10 >= 5) || (count % 10 == 0) {
            return .TMany
        }
        
        if (count % 10 >= 2) && (count % 10 <= 4) {
            return .TOther
        }
        
        return .TOther
    }
}
