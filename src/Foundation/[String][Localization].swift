//
//  [String][Localization].swift
//  Pods-TDemo
//
//  Created by Virpik on 16/10/2018.
//

import Foundation

/// Саппорт при работе с локализацией.
/// Для работы с колличественными склонениями
/// Необходимо дублировать в .string файле, продублировать склоняемую фразу:
/// "Значение-TOne" = "1 значение";
/// "Значение-TMany" = "2 значения";
/// "Значение-TOther" = "5 значений";

/// Типы колличественных склонений
public enum StringDecline: String {
    case one /// Для значений, заканчивающихся на '1' кроме числа 11
    case many /// Для значений от 5 до 20 и чисел оканичающихся на '0' или  больше пяти
    case other /// Для остальных значений
}

extension StringDecline {
    /// Строковое значение
    public var key: String {
        switch self {
            case .one: return "TOne"
            case .many: return "TMany"
            case .other: return "TOther"
        }
    }
}

public extension String {
    
    /// Возвращает локализацию, ключь - текущее значение
    public var localize: String {
        return self.localize()
    }
    
    /// Возвращает локализацию, ключь - текущее значение. Если указан 'count' - Включается поиск склонений
    public func localize(comment: String? = "", count: Int? = nil) -> String {
        var str = self
        
        if let count = count {
            str +=  "-"+self.declension(count).key
        }
        
        return  NSLocalizedString(str, comment: comment ?? "")
    }
    
    /// Возвращает тип значения по числу
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
