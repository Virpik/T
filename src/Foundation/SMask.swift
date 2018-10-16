//
//  SMask.swift
//  
//
//  Created by Virpik on 12/12/2017.
//

import Foundation

/// Для формирования строки по маске
///
/// Примеры масок:
/// - '+7 (###) ### ## ##' + '9231231212' = '+7 (923) 123 12 12'
/// - '#### #### #### *' + '1234qwerty0987WWW' = '1234 qwer ty09 87WWW'
/// - '##-##-##-\#-##' + 'ABCDEFGHIJKLMNOPQR' = 'AB-CD-EF-#-GH'
///
/// Формат маски:
/// '#' - Значение, которое требуется подменить
/// '*' - Все оставшиеся значения
/// '\' - Экранирование, игнорирует экранируемый символ
///
public struct SMask {
    
    /// Строка, к которой принимается маска
    public var raw: String
    
    /// Маска
    public var mask: String
    
    /// Значение после применения маски
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
