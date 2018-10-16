//
//  [String][Localization].swift
//  Pods-TDemo
//
//  Created by Virpik on 16/10/2018.
//

import Foundation

public enum StringDecline: String {
    case one, many, other
}

extension StringDecline {
    public var key: String {
        switch self {
            case .one: return "TOne"
            case .many: return "TMany"
            case .other: return "TOther"
        }
    }
}

public extension String {
    
    public var localize: String {
        return self.localize()
    }
    
    public func localize(comment: String? = "", count: Int? = nil) -> String {
        var str = self
        
        if let _count = count {
            str +=  "-"+self.declension(_count).key
        }
        
        return  NSLocalizedString(str, comment: "")
    }
    
    private func declension(_ count: Int) -> StringDecline {
        
        if (count % 10 == 1) && (count != 11) {
            return .one
        }
        
        if (count >= 5) && (count <= 20) {
            return .many
        }
        
        if (count % 10 >= 5) || (count % 10 == 0) {
            return .many
        }
        
        if (count % 10 >= 2) && (count % 10 <= 4) {
            return .other
        }
        
        return .other
    }
}
