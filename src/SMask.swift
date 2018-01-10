//
//  SMask.swift
//  
//
//  Created by Virpik on 12/12/2017.
//

import Foundation

public struct SMask {
    public var raw: String
    
    public var mask: String
    
    public var value: String {
        return self._go()
    }
    
    public init(mask: String, str: String) {
        self.raw = str
        self.mask = mask
    }
    
    private func _go() -> String {
        var result = ""

        var index: Int = 0
        var ignoreNext = false
        
        for char in self.mask {
            let str = String(char)
            
            if str == "\\" {
                ignoreNext = true
                continue
            }
            
            if str == "#" && !ignoreNext {
                
                if self.raw.count <= index {
                    continue
                }
                
                result += self.raw[index]
                
                index += 1
                
                continue
            }
            
            if str == "*" && !ignoreNext {
                result += self.raw[index ..< Int(self.raw.endIndex.encodedOffset)]
                return result
            }
            
            result += str
            
            ignoreNext = false
        }
        
        return result
    }
    
}
