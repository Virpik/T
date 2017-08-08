//
//  TString.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

fileprivate enum TStringDecline: String {
    case TOne, TMany, TOther
}

public extension String {
    
    public var capitalizingFirstLetter: String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
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
